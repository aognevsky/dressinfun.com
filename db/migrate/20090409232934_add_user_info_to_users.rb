class AddUserInfoToUsers < ActiveRecord::Migration
  def self.up
		add_column :users, :icq,			:string,	:default => ''
		add_column :users, :skype,		:string,	:default => ''
		add_column :users, :jabber, 	:string,	:default => ''
		add_column :users, :gtalk,		:string,	:default => ''
		add_column :users, :twitter, 	:string,	:default => ''
		add_column :users, :website, 	:string,	:default => ''
		
		add_column :users, :birthday, :date
		add_column :users, :about, 		:text,		:null => false
		add_column :users, :location, :string, 	:default => ''
		add_column :users, :sex, 			:boolean, :default => 1
  end

  def self.down
		remove_column :users, :icq
		remove_column :users, :skype
		remove_column :users, :jabber
		remove_column :users, :gtalk
		remove_column :users, :twitter
		remove_column :users, :website
		
		remove_column :users, :birthday
		remove_column :users, :about
		remove_column :users, :location
		remove_column :users, :sex
	
  end
end
