#!/usr/bin/ruby

require 'sqlite3'
require_relative './MessagesGateway'

class ContactsGateway
	FIRST = "First"
	LAST = "Last"
	CONTACT_ID = "ContactID"

	attr_accessor :contacts

	def initialize(source_db_url)
		@contacts = self.get_contacts(source_db_url)
	end

	def get_contacts(source_db_url)
		begin
			db = SQLite3::Database.open source_db_url

			stm = db.prepare "SELECT First, Last, ROWID, value FROM ABMultiValue, ABPerson WHERE record_id = ROWID AND value is not null"
			results = stm.execute # implicit return

			temp_contacts_hashes = {}
			results.each do |contact|
				new_contact_hash = {}
				new_contact_hash[FIRST] = contact[0]
				new_contact_hash[LAST] = contact[1]
				new_contact_hash[CONTACT_ID] = contact[2]
				dirty_unique_id = contact[3]
				unique_id = self.class.normalize_unique_id(dirty_unique_id)
				new_contact_hash[MessagesGateway::UNIQUE_ID] = unique_id
				temp_contacts_hashes[unique_id] = new_contact_hash if unique_id
			end

			odd_contacts = knownContactsWithUniqueIDs()

			contacts_hashes = temp_contacts_hashes.merge(odd_contacts)

			return contacts_hashes

		rescue SQLite3::Exception => e
			puts 'Exception occured'
			puts e
		end
	end

	def contact_id_to_readable_name( contact_id )

		name = contact_id

		contact_hash = @contacts[contact_id]
		if !contact_hash.nil?
			first = contact_hash[FIRST]
			last = contact_hash[LAST]
			n = first.nil? ? "" : first
			n = last.nil? ? n : n + last
			if (n != "") then name = n end
		end
		return name

	end

	def self.normalize_unique_id( dirty_unique_id)
		if dirty_unique_id.nil? then return nil end
		inter = dirty_unique_id.gsub(/( |\+|\(|\)|\-|\.)/,"")
		clean_unique_id = inter.sub(/^1/, "")
		clean_unique_id
	end

	def knownContactsWithUniqueIDs()
		contacts = {}
		raw_contacts = {}

		contact_id_generator = 10000
		raw_contacts['ki'] = ['4046555562','falcorkle@gmail.com', '7708919910', 'mmccorkie2@student.gsu.edu', '61405738298']

		raw_contacts.each do |name, unique_ids|
			contact_id = contact_id_generator
			contact_id_generator += 1
			unique_ids.each do |unique_id|
				contact = {}
				contact[FIRST] = name
				contact[MessagesGateway::UNIQUE_ID] = unique_id
				contact[CONTACT_ID] = contact_id
				contacts[unique_id] = contact
			end
		end
		return contacts
	end

end
















