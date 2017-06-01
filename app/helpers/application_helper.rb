module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  # склонятор
  def declination(num, krokodil, krokodila, krokodilov)
    if num == nil || !num.is_a?(Numeric)
      num = 0
    end

    # остаток от 100
    big_vestige = num % 100

    if big_vestige.between?(11, 14) || num.between?(11, 14)
      return krokodilov
    end

    # остаток от 10
    vestige = num % 10

    if vestige == 1
      return krokodil
    elsif vestige >=2 && vestige <= 4
      return krokodila
    elsif vestige >= 5 && vestige <= 9 || vestige == 0
      return  krokodilov
    end
  end

end
