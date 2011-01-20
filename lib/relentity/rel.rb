module Relentity class Rel

  include Entity

  def refs? entity
    refs.include? entity
  end

end end
