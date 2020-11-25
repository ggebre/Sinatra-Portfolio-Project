class Appointment < ActiveRecord::Base 
    belongs_to :patient 
    belongs_to :staff 
    has_many :prescriptions

    def compare_date(date)
        formatted_date = date.split('-').join(',') 
        Time.new(formatted_date) 
    end

    def self.ordered_appointments 
        self.order(appointment_date: :desc)
    end

    def self.appointments_for_a_patient_with(patient_id)
        # self.find_by(patient_id: patient_id)
        self.select {|appointment| appointment.patient_id == patient_id}
    end

    def self.appointments_for_a_staff_with(staff_id)
        
        self.select {|appointment| appointment.staff_id == staff_id}

    end

    def formatted_date (date)

        formatted_date = date.split('-')
        Time.new(formatted_date[0],formatted_date[1],formatted_date[2] ) 
    end

    def is_upcoming?
        
        # date = self.appointment_date
        # self.formatted_date(date) < Time.now
        self.appointment_date < Time.now
    end
    
end