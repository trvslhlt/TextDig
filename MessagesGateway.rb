#!/usr/bin/ruby

require 'sqlite3'
require 'digest/sha1'

require_relative './ContactsGateway'


class MessagesGateway
	UNIQUE_ID = "UniqueID"
	TEXT = "Text"
	TIME = "Time"
	TYPE = "Type"
	DATE = "Date"
	ATTACHMENT_ID = "AttachmentID"

	MIME_TYPE = "mime_type"
	FILENAME = "filename"
	SHA1_FILENAME = "sha1_filename"

	attr_accessor :messages, :attachments, :source_db_url, :message_fields, :checkpoint_timestamp

	def initialize(source_db_url, most_recent_clean_message_timestamp)
		begin 
			@source_db_url = source_db_url
			@checkpoint_timestamp = most_recent_clean_message_timestamp
			@source_db = SQLite3::Database.open @source_db_url
			@message_fields = []
			@messages = self.get_messages

			unless @messages.nil?
				@attachments = self.get_attachments
			end
		rescue SQLite3::Exception => e
			puts 'Exception:'
			puts e
		end
	end





	def get_messages
		stm = @source_db.prepare( self.messages_query_string )
		@message_fields = stm.columns

		msg_hashes = []
        msg_arrays = stm.execute
        msg_arrays.each { |msg_array| msg_hashes << message_array_to_hash(msg_array) }

        msg_hashes.each do |msg_hash|
        	unique_id = msg_hash[UNIQUE_ID]
        	msg_hash[UNIQUE_ID] = ContactsGateway::normalize_unique_id(unique_id)
        end

        return msg_hashes
	end

	def get_attachments
		temporary_attachments = []

		stm = @source_db.prepare self.class.attachment_query_string(0)
		attachment_field_names = stm.columns
		filename_index = attachment_field_names.index(FILENAME)
		mime_type_index = attachment_field_names.index(MIME_TYPE)

		@messages.each do |message|

			attachment_id = message[ATTACHMENT_ID]
			unless attachment_id.nil?

				stm = @source_db.prepare self.class.attachment_query_string(attachment_id)
				result = stm.execute
				result.each do |attachment|

					original_filename = attachment[filename_index]
					filename = cleanup_attachment_filepath(original_filename)
					sha1_filename = Digest::SHA1.hexdigest filename
					mime_type = attachment[mime_type_index]

					new_attachment = {}
					new_attachment[ATTACHMENT_ID] = attachment_id
					new_attachment[SHA1_FILENAME] = sha1_filename
					new_attachment[FILENAME] = filename
					new_attachment[MIME_TYPE] = mime_type
					temporary_attachments << new_attachment
				end
			end
		end

		return temporary_attachments
	end

	def cleanup_attachment_filepath(original_filepath)
		to_remove = "~/Library" #/~\/Library/ <=========== as regexp
		to_prepend = "MediaDomain-Library"
		original_filepath.gsub(/#{Regexp.escape(to_remove)}/, to_prepend)
	end

	def message_array_to_hash( msg_array )
		msg_hash = {}
		@message_fields.each_with_index do |field, index|
			msg_hash[field] = msg_array[index]
		end
		return msg_hash
	end

	def most_recent_message
		most_recent_message_unique_id = 0
		@messages.each do |m|
			most_recent_message_unique_id = [most_recent_message_unique_id, m[DATE]].max
		end
		return most_recent_message_unique_id
	end

	def messages_query_string
		checkpoint = @checkpoint_timestamp - 978307200 - 1000

		stm = "SELECT 
            m.rowid as RowID,
            h.id AS #{UNIQUE_ID}, 
            CASE is_from_me 
                WHEN 0 THEN \"from\" 
                WHEN 1 THEN \"to\" 
                ELSE \"Unknown\" 
            END as Type, 
            CASE 
                WHEN date > 0 then TIME(date + 978307200, 'unixepoch', 'localtime')
                ELSE NULL
            END as Time,
            CASE 
                WHEN date > 0 THEN strftime('%Y%m%d', date + 978307200, 'unixepoch', 'localtime')
                ELSE NULL
            END as Date, 
            CASE 
                WHEN date > 0 THEN date + 978307200
                ELSE NULL
            END as #{TIME}, 
            text as #{TEXT},
            maj.attachment_id AS #{ATTACHMENT_ID}
        FROM message m
        LEFT JOIN handle h ON h.rowid = m.handle_id
        LEFT JOIN message_attachment_join maj
        ON maj.message_id = m.rowid
        WHERE Time < #{checkpoint}
        ORDER BY UniqueID, Date, Time"
        p stm
        return stm
	end

	def self.attachment_query_string(row_id)
		"SELECT * FROM attachment WHERE ROWID = \"#{row_id}\""
	end

end









