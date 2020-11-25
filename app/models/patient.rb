class Patient < ActiveRecord::Base
    has_one :user
    has_many :comments 
    has_many :appointments 
    has_many :staff, through: :appointments
    has_many :prescriptions,  through: :appointments


      def self.find_patient(user_id) 
          self.find {|patient| patient.user == User.find_by(id: user_id)}
      end
      
      
end