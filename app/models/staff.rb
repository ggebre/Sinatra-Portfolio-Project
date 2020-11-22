class Staff < ActiveRecord::Base 
    has_one :user
    has_many :comments
    has_many :appointments 
    has_many :patients, through: :appointments

    def self.find_staff(user_id)
        self.all.select {|staff| staff if staff.user}.find{|staff| staff.user.id == user_id}
    end
    # checks if the staff is doctor or not
    def self.doctors_list  
        self.all.select {|staff| staff.is_doctor}
    end
    # all patients 
    def patients 
        self.appointments.map {|appointment| Patient.find_by(id: appointment.patient_id)}
    end



    def slug 
        self.name.strip.gsub(/[\s\t\r\n\f]/,'-').gsub(/\W/,'-').downcase
    end
    
    def self.find_by_slug(slug)
        self.all.detect {|staff| staff.slug == slug}
    end 
end