class Patient < ActiveRecord::Base
    has_one :user
    has_many :comments 
    has_many :appointments 
    has_many :staff, through: :appointments
    has_many :prescriptions,  through: :appointments


      # def self.find_patient(user_id) 
      #     self.find {|patient| patient.user == User.find_by(id: user_id)}
      # end
  
      # def doctors  
      #     self.appointments.map {|appointment| Staff.find_by(id: appointment.staff_id)}
      # end

      def todays_appointment 
        # self.appointments.detect {|appointment| appointment.appointment_date.strip == todays_date}
        self.appointments.where(appointment_date:  Time.now.strftime('%Y-%m-%d')).first
      end
    
      def slug 
        self.name.strip.gsub(/[\s\t\r\n\f]/,'-').gsub(/\W/,'-').downcase
      end
    
      def self.find_by_slug(slug)
        self.find {|patient| patient.slug == slug}
      end 

end