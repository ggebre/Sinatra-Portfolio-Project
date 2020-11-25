class Staff < ActiveRecord::Base 
    has_one :user
    has_many :comments
    has_many :appointments 
    has_many :patients, through: :appointments

    # def self.find_current_user_staff(current_user)
    #     self.find {|staff| staff.user == current_user}
    # end
   
    def self.all_practitioners 
        self.select{|staff| staff.is_doctor}
    end

    def is_doctor_of?(current_user)
        self.patients.find{|patient| patient.user == current_user}
    end
end