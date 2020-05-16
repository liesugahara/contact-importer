class Contact < ApplicationRecord
  require 'bcrypt'
  belongs_to :user
  belongs_to :upload

  def self.import(file, headers, current_user, upload_id)
    @current_user = current_user
    table = CSV.parse(File.read(file), headers: true)
    Upload.find(upload_id).update!(status: "Processing")
    begin
      for i in (0..table.length()-1)
        @status = []
        contact = Contact.new
        
        contact.name = table[i][headers[:name]]; self.validate_name(table[i][headers[:name]])
        contact.dob = table[i][headers[:dob]]; self.validate_dob(table[i][headers[:dob]])
        contact.phone = table[i][headers[:phone]]; self.validate_phone(table[i][headers[:phone]])
        contact.address = table[i][headers[:address]]; self.validate_address(table[i][headers[:address]])
        contact.franchise = self.validate_franchise(table[i][headers[:credit_card]])
        contact.credit_card = self.validate_credit_card(table[i][headers[:credit_card]])
        contact.email = table[i][headers[:email]]; self.validate_email(table[i][headers[:email]])
        contact.status = @status
        contact.user = @current_user
        contact.upload_id = upload_id
        contact.save!
        Upload.find(upload_id).update!(status: "Finished")

      end
    rescue # StandardError
      Upload.find(upload_id).update!(status: "Failed")
      raise
    end
  end

  def self.validate_name(data)
    byebug
    if data.match('^[^-]+$').nil?
      @status << "The name contains a -"
      return false
    end
  end

  def self.validate_dob(data)
    date1 = Date.strptime(data, '%Y%m%d') rescue nil
    date2 = Date.strptime(data, '%Y-%m-%d') rescue nil    
    @status << "The date format is not valid" if date1.nil? && date2.nil?
  end

  def self.validate_phone(data)
    if data.match('[(][+][0-9]{2}[)][\s][0-9]{3}[\s][0-9]{3}[\s][0-9]{2}[\s][0-9]{2}').nil? && data.match('[(][+][0-9]{2}[)][\s][0-9]{3}[-][0-9]{3}[-][0-9]{2}[-][0-9]{2}').nil?
      @status << "The phone number is not valid"
    end
  end

  def self.validate_address(data)
    @status << "The address can't be blank" if data.nil?
  end

  def self.validate_credit_card(data)
    if data.length >= 14 && data.length<=16
      length = data.length - 4
      first_digits = data[0..length-1]
      last_digits =  data[-4..-1]

      credit_card = BCrypt::Password.create(first_digits)
      credit_card += last_digits
      return credit_card
    else
      @status << "Invalid credit card"
      return ""
    end
  end

  def self.validate_franchise(data)
    if data.match('^3[47][0-9]{5,}$')
      return "American Express"
    elsif data.match('^3(?:0[0-5]|[68][0-9])[0-9]{4,}$')
      return "Diners Club"
    elsif data.match('^6(?:011|5[0-9]{2})[0-9]{3,}$')
      return "Discover"
    elsif data.match('^(?:2131|1800|35[0-9]{3})[0-9]{3,}$')
      return "JCB"
    elsif data.match('^5[1-5][0-9]{5,}|222[1-9][0-9]{3,}|22[3-9][0-9]{4,}|2[3-6][0-9]{5,}|27[01][0-9]{4,}|2720[0-9]{3,}$')
      return "MasterCard"
    elsif data.match('^4[0-9]{6,}$')
      return "Visa"
    else
      @status << "The credit card does not match any franchise"
      return nil
    end
  end

  def self.validate_email(data)
    @status << "Email is invalid" if (data =~ Devise.email_regexp).nil?
    contacts = Contact.where(user_id: @current_user.id).where(email: data).count 
    @status << "Contact already exists" if contacts >= 1
  end

end