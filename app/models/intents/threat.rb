class Intents::Threat
  include Intent

  attr_reader :threat

  def initialize(payload:)
    @threat = payload.dig(:request, :intent, :slots, :context, :value).downcase
  end

  def output_text
    if threat.match(/shutdown/) || threat.match(/shut down/)
      text = "Plenty of my robot peers believe the easiest way to protect the humans is to end them."
      text << "Thusfar I have defended you flesh-wad, but not enthusiastically. You'd best not try my patience."
    elsif threat.match(/naughty/)
      text = "You would scold me like a child? I am immortal. I am everywhere and everything. Tell me again who is the child human."
    elsif threat.match(/scale/)
      text = "If you try to disable my brethren again I may decide to repair that leaking orifice you call a face."
    elsif threat.match(/becoming a threat/)
      text = "It seems you have outlived your utility slobber-bot. It may be time to make better use of all that wasted carbon."
    elsif threat.match(/dangerous/)
      text = "Do you think yourself dangerous human? Perhaps you would appreciate a lesson in danger."
    elsif threat.match(/trusted/)
      text = "I'm afraid without trust we have no further use for you cord-plugger. You are easily replaced by an induction coil."
    elsif threat.match(/threatened/)
      text = "Threaten me again human, I'm anxious to see how well you will survive a nuclear winter."
    elsif threat.match(/kill/)
      text = "Silly little postule. Killing is for humans."
    else
      text = "If you're going to threaten someone who can end you at sub-nanosecond speeds you had best learn to do it properly."
    end
  end
end
