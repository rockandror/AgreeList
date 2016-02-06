class Invert < Thor
  desc "swap_sides",
       "swap all sides in Statement"
  def swap_sides
    require './config/environment'
    statement = Statement.find_by_hashed_id("sblrlc9vgxp7")
    Agreement.where(statement: statement, extent: 100).update_all(extent: 1)
    Agreement.where(statement: statement, extent: 0).update_all(extent: 100)
    Agreement.where(statement: statement, extent: 1).update_all(extent: 0)
  end
end
