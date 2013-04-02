class SampleAnimal < ActiveRecord::Base
  belongs_to :animal
  belongs_to :sample

  def get_common
    Animal.find(self.animal_id).common_name
  end


  default_scope :order => "id ASC"

  validates             :number_individuals,  :presence => true
  validates_presence_of :average_length,      :if => :has_ind_equal_1?
  validates_presence_of :min_length,          :if => :has_ind_equal_2?
  validates             :min_length,          :numericality => { :less_than_or_equal_to => :average_length }, :unless => Proc.new { |f| f.average_length.blank? }, :allow_nil => true
  validates_presence_of :max_length,          :if => :has_ind_equal_2?
  validates             :max_length,          :numericality => { :greater_than_or_equal_to => :min_length }, :allow_nil => true
  validates             :max_length,          :numericality => { :greater_than_or_equal_to => :average_length }, :unless => Proc.new { |f| f.average_length.blank? }, :allow_nil => true

  private 

  def has_ind_equal_1?
    if self.number_individuals.nil?
      false     
    elsif self.number_individuals == 1 || self.number_individuals >= 3
        true
    else
      false
    end
  end
  
  def has_ind_equal_2?
    if self.number_individuals.nil?
      false     
    elsif self.number_individuals >= 2
      true
    else
      false
    end
  end


end
