module Relentity class Rel

  include Entity

  def other entity
    case entity
    when refs.first then refs.last
    when refs.last  then refs.first
    end
  end

  def refs? entity
    refs.include? entity
  end

end end
