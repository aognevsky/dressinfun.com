require 'digest/sha1'

class User < ActiveRecord::Base


#
# Friends
#

  has_many :friendships

  has_many	:friendship_by_me, 
						:class_name => 'Friendship',
						:foreign_key => 'user_id'

	has_many	:friendship_for_me, 
						:class_name => 'Friendship',
						:source => :fan,
						:foreign_key => 'friend_id'

	has_many	:friends,
						:through => :friendship_by_me, 
						:source => :fan

	has_many	:fans,
						:through => :friendship_for_me, 
						:source => :friend


	has_private_messages


#
# Userpics
#

  has_attached_file	:userpic,
										:whiny_thumbnails => true,
										:default_style => :thumb,
    								:styles =>	{ :thumb => "90x90#",
 																	:comments	=> "25x25#" 
																}

  has_and_belongs_to_many :roles

  # has_role? simply needs to return true or false whether a user has a role or not.  
  # It may be a good idea to have "admin" roles return true always
  def has_role?(role_in_question)
    @_list ||= self.roles.collect(&:name)
    return true if @_list.include?("admin")
    (@_list.include?(role_in_question.to_s) )
  end
  # ---------------------------------------


  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

	# Login
	# TODO Добавить проверку логина на letters-only (без спецсимволов)
  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

	# Name 
  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

	# E-mail
  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

	# Userpic
	#validates_attachment_presence :userpic // This shit kills 


	# TODO Добавить в итоге все необходимые поля, остальные убрать
  # attr_accessible :login, :email, :name, :password, :password_confirmation



  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login.downcase) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  protected



end
