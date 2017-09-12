# Deploy Helper
# Returns deploy date and version which are hardcoded values
# Inspiration from https://github.com/noctrl-csc694-fall2016/giftgarden/blob/master/app/helpers/application_helper.rb
# Author: Debra J
module DeployHelper
  
  #Deploy variables, change these when a new deploy is performed
  @@geogem_version = "V0.1"
  @@geogem_version_detailed = "V0.1-alpha"
  @@geogem_deploy_date = "September 12, 2017"

  def DeployHelper.geogem_version
    @@geogem_version
  end
  
  def DeployHelper.geogem_version_detailed
    @@geogem_version_detailed
  end  
  def DeployHelper.geogem_deploy_date
    @@geogem_deploy_date
  end
end 