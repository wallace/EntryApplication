class Dashboard < ActiveRecord::Base  
 
def diver_list(current_diver)
  if current_diver.role == "admin"
    @boat_logs      = BoatLog.all
    @boatlog_divers = RepLog.group(:diver_id).count(:id)
    @sample_divers  = DiverSample.primary.group(:diver_id).count(:id)
    @lpi_divers     = BenthicCover.group(:diver_id).count(:id)
    @demo_divers    = CoralDemographic.group(:diver_id).count(:id)
    hash_merge(@boatlog_divers, @sample_divers, @lpi_divers, @demo_divers).keys
  else
    @boat_logs      = BoatLog.where( "boatlog_manager_id=?", current_diver.boatlog_manager_id )
    @boatlog_divers = RepLog.joins(station_log: :boat_log).where("boat_logs.boatlog_manager_id = ?", current_diver.boatlog_manager_id).group(:diver_id).count(:id)
    @sample_divers  = DiverSample.primary.joins(:sample).where("samples.boatlog_manager_id = ?", current_diver.boatlog_manager_id).group(:diver_id).count(:id)
    @lpi_divers     = BenthicCover.where("boatlog_manager_id = ?", current_diver.boatlog_manager_id).group(:diver_id).count(:id)
    @demo_divers    = CoralDemographic.where("boatlog_manager_id = ?", current_diver.boatlog_manager_id).group(:diver_id).count(:id)
    hash_merge(@boatlog_divers, @sample_divers, @lpi_divers, @demo_divers).keys
  end
end
 
    def hash_merge *hashes
      hashes.inject :merge
    end
 
    def check_val (v)
      v.nil? ? 0 : v
    end
 
  def divers(current_diver)
    diver_list(current_diver).map do |diver|
      organized_hash[diver] = { "boat"   => check_val(@boatlog_divers[diver]), 
                                "sample" => check_val(@sample_divers[diver]), 
                                "lpi"    => check_val(@lpi_divers[diver]), 
                                 "demo" => check_val(@demo_divers[diver]) }
    end
  end
end
