# Deploy Helper - deploy date and version help
# Inspiration from https://github.com/noctrl-csc694-fall2016/giftgarden/blob/master/app/helpers/application_helper.rb
# Author: Debra J
module DeployHelper
  
  #
  # IMPORTANT!
  # These 3 global variables are all you need to change when deploying a new version
  #
  @@geogem_version = "V0.3"
  @@geogem_version_detailed = "V0.3-alpha"
  @@geogem_deploy_date = "December 2, 2017"

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
