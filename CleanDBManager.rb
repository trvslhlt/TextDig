#!/usr/bin/ruby

require 'sqlite3'

require_relative './ContactsGateway'
require_relative './MessagesGateway'

class CleanDBManager
	MESSAGES_TABLE = "messages"
	CONTACTS_TABLE = "contacts"
	ATTACHMENTS_TABLE = "attachments"

	def initialize( db_url )

		begin 
			@db = SQLite3::Database.open db_url
			self.prepare_schema

		rescue SQLite3::Exception => e
			puts 'Exception:'
			puts e
		end

	end

	def prepare_schema
		msg_stm = "CREATE TABLE IF NOT EXISTS #{MESSAGES_TABLE}(Id INTEGER PRIMARY KEY,
			#{MessagesGateway::UNIQUE_ID} TEXT,
			#{MessagesGateway::TYPE} TEXT,
			#{MessagesGateway::TIME} INTEGER,
			#{MessagesGateway::DATE} TEXT,
			#{MessagesGateway::TEXT} TEXT,
			#{MessagesGateway::ATTACHMENT_ID} INTEGER)"
		@db.execute msg_stm

		att_stm = "CREATE TABLE IF NOT EXISTS #{ATTACHMENTS_TABLE}(Id INTEGER PRIMARY KEY,
			#{MessagesGateway::ATTACHMENT_ID} INTEGER,
			#{MessagesGateway::MIME_TYPE} TEXT,
			#{MessagesGateway::SHA1_FILENAME} TEXT)"
		@db.execute att_stm

		cts_stm = "CREATE TABLE IF NOT EXISTS #{CONTACTS_TABLE}(Id INTEGER PRIMARY KEY,
			#{ContactsGateway::CONTACT_ID} INTEGER,
			#{MessagesGateway::UNIQUE_ID} TEXT,
			#{ContactsGateway::FIRST} TEXT,
			#{ContactsGateway::LAST} TEXT)"
		@db.execute cts_stm
	end

	def populate_messages_table (messages)
		msg_count = messages.count
		fields = "#{MessagesGateway::UNIQUE_ID},#{MessagesGateway::TYPE},#{MessagesGateway::TIME},#{MessagesGateway::DATE},#{MessagesGateway::TEXT},#{MessagesGateway::ATTACHMENT_ID}"
		messages.each_with_index do |m, index|
			p "#{index} / #{msg_count}"
			unique_id = m[MessagesGateway::UNIQUE_ID]
			type = m[MessagesGateway::TYPE]
			time = m[MessagesGateway::TIME]
			date = m[MessagesGateway::DATE]
			text = m[MessagesGateway::TEXT]
			attachment_id = m[MessagesGateway::ATTACHMENT_ID] ? m[MessagesGateway::ATTACHMENT_ID] : "NULL"
			@db.execute("INSERT INTO #{MESSAGES_TABLE}(#{fields}) VALUES (?, ?, ?, ?, ?, ?)", [unique_id, type, time, date, text, attachment_id])
		end
	end

	def populate_attachments_table (attachments)
		att_count = attachments.count
		fields = "#{MessagesGateway::ATTACHMENT_ID},#{MessagesGateway::SHA1_FILENAME},#{MessagesGateway::MIME_TYPE}"
		attachments.each_with_index do |a, index|
			p "#{index} / #{att_count}"
			attachment_id = a[MessagesGateway::ATTACHMENT_ID]
			filename = a[MessagesGateway::SHA1_FILENAME]
			type = a[MessagesGateway::MIME_TYPE]
			@db.execute("INSERT INTO #{ATTACHMENTS_TABLE}(#{fields}) VALUES (?, ?, ?)", [attachment_id, filename, type])
		end
	end

	def populate_contacts_table (contacts)
		cts_count = contacts.count
		fields = "#{MessagesGateway::UNIQUE_ID},#{ContactsGateway::CONTACT_ID},#{ContactsGateway::FIRST}, #{ContactsGateway::LAST}"
		contacts.each_with_index do |cArr, index|
			p "#{index} / #{cts_count}"
			c = cArr[1]
			unique_id = c[MessagesGateway::UNIQUE_ID]
			contact_id = c[ContactsGateway::CONTACT_ID]
			first = c[ContactsGateway::FIRST]
			last = c[ContactsGateway::LAST]
			@db.execute("INSERT INTO #{CONTACTS_TABLE}(#{fields}) VALUES (?, ?, ?, ?)", [unique_id, contact_id, first, last])
		end
	end
end













