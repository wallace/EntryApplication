# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

puts "Seeding database with data"

SampleType.delete_all
SampleType.connection.execute( 'ALTER SEQUENCE sample_types_id_seq RESTART WITH 1' )
open("#{Rails.root}/db/SupportData/SampleTypeList.csv") do |sampleTypes|
  sampleTypes.read.each_line do|sampleType|
    SampleTypeName, SampleTypeDesc = sampleType.chomp.split(",")
    SampleType.create( :sample_type_name => SampleTypeName, :sample_type_description => SampleTypeDesc )
  end
end

HabitatType.delete_all
HabitatType.connection.execute( 'ALTER SEQUENCE habitat_types_id_seq RESTART WITH 1' )
open("#{Rails.root}/db/SupportData/HabitatList.csv") do |habitatTypes|
  habitatTypes.read.each_line do|habitatType|
    HabName, HabDesc = habitatType.chomp.split(",")
    HabitatType.create( :habitat_name => HabName, :habitat_description => HabDesc )
  end
end

Diver.delete_all
Diver.connection.execute( 'ALTER SEQUENCE divers_id_seq RESTART WITH 1' )
open("#{Rails.root}/db/SupportData/DeviseDivers.csv") do |divers|
  divers.read.each_line do|diver|
    DiverNumber, DiverName, UserName, Email, Password, Active = diver.chomp.split(",")
    Diver.create( :diver_number => DiverNumber, :diver_name => DiverName, :username => UserName, :email => Email, :password => Password, :active => Active )
  end
end

Animal.delete_all
Animal.connection.execute( 'ALTER SEQUENCE animals_id_seq RESTART WITH 1' )
open("#{Rails.root}/db/SupportData/SpeciesList.csv") do |animals|
  animals.read.each_line do |animal|
    SppCode, ScientificName, CommonName, MaxSize, MinSize, MaxNumber = animal.chomp.split(",")
    Animal.create( :species_code => SppCode, :scientific_name => ScientificName, :common_name => CommonName, :max_size => MaxSize, :min_size => MinSize, :max_number => MaxNumber )
  end
end

CoverCat.delete_all
CoverCat.connection.execute( 'ALTER SEQUENCE cover_cats_id_seq RESTART WITH 1' )
open("#{Rails.root}/db/SupportData/PointInterceptCats.csv") do |corals|
  corals.read.each_line do |coral|
    CoverCat.create( :name => coral.chomp )
  end
end
