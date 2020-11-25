class Appointment < ActiveRecord::Base 
    belongs_to :patient 
    belongs_to :staff 
    has_many :prescriptions


end