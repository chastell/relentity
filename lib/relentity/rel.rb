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

  def rel_to_other entity
    case entity
    when refs.first then rels.last
    when refs.last  then rels.first
    end
  end

end end
