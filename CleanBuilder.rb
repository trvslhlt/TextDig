#!/usr/bin/ruby

require_relative './ContactsGateway'
require_relative './MessagesGateway'
require_relative './CleanDBManager'

contacts_db = '31bb7ba8914766d4ba40d6dfb6113c8b614be442'
messages_db = '3d0d7e5fb2ce288813306e4d4636395e047a3d28'
clean_db = 'clean.db'
backup_directory = 'most_recent_backup/'
contacts_db_path = backup_directory + contacts_db
messages_db_path = backup_directory + messages_db

clean_manager = CleanDBManager.new clean_db
most_recent_clean_message_timestamp = clean_manager.most_recent_time_stamp
contacts_gateway = ContactsGateway.new contacts_db_path
messages_gateway = MessagesGateway.new(messages_db_path, most_recent_clean_message_timestamp) 
contacts = contacts_gateway.contacts
messages = messages_gateway.messages
attachments = messages_gateway.attachments

contacts.each { |c| p c }
# p messages.count
# p "...inserting contacts"
# a.populate_contacts_table contacts
# p "...inserting attachments"
# a.populate_attachments_table attachments
p "...inserting messages"
# clean_manager.populate_messages_table messages


# p a.most_recent_time_stamp
# p messages_gateway.most_recent_message


