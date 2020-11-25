class Patient < ActiveRecord::Base
    has_one :user
    has_many :comments 
    has_many :appointments 
    has_many :staff, through: :appointments
    has_many :prescriptions,  through: :appointments
    
end