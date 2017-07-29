module SchoolsHelper

  # return ux string for school name
  def ux_school_name( school, num_chars=20)
    num_chars > 0 ? school.full_name.truncate( num_chars) : school.full_name
  end
end
