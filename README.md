# Simple Shorter: Jen's own linkshortner

## Tech Inventory
  
- Ruby on Rails
- Rspec
- Minimal Backbone.js/jQuery
- Twitter Bootstrap

I created this Backbone/Rails app because sometimes it's nice to have shortlinks, but I wanted to retain control of my links rather than routing them through a third-party service I have no control over.  In it's present form, it only has one user-facing feature: enter a URL and recieve back a valid shortlink.  

<a href="http://www.jlh.io">
![jlh.io](http://www.github.com/jhamon/simple_shortener/raw/master/screenshot.png)
</a>

## Rails Backend
Even though the public-facing site is almost trivial in what it offers at this time, I have kept in mind the analytics features of sites like Bitly.com while implementing a backend with seperate models for `PageView`, `Shortlink`, `TargetUrl`, and `User`.

When you follow a shortlink, a controller logs that visit by creating a `PageView` before sending you on your way to your destination.  Having distinct `Shortlink` and `TargetUrl` means that I will be able to easily compute and show viist analytics on a per-site or per-shortlink or per-user basis if I ever get around to it. `Shortlink` and `TargetUrl` must be seperate models because a user might own a shortlink but not the associated target url; many people might create their own shortlinks for the same online destination.

The site serves my present needs just fine in its present form so I haven't built-out the analytics frontend.  But I enjoyed thinking about the associations needed in the domain model on the backend.  Maybe one day I'll revisit this to flesh out the analytics.

## An aside on shortcode generation and namespace conservation

Ruby lets us cheat for modest numbers of shortcodes.  The standard `.to_s` method accepts an optional radix parameter that will convert a number to a base encoded string.  For example, `10.to_s(2)` returns `"1010"`.  The largest allowed radix is 36, which represents `/[a-z0-9]/`.  For my app that is sufficient, since that base 36 encoding gives me is enough for `60_466_176` shortlink codes up to five characters long.

But I got to wondering.  What if I were bitly.com with millions of active users, and I didn't want to ever sunset/recycle any links?  I would need to make even denser use of the available namespace.  Adding in the notion of capitalization gets us up to base 62 and `916_132_832` shortcodes under five characters in length.  Not too shabby, but also not really that much compared to the amount of people sharing content on the internet.  

If the ugly urls with `=` and `_` are in play then I could pack `1_073_741_824` into five chars, but it seems like a tough choice to decide whether the extra `17%` namespace density is worth having ugly urls since urls are the most visible part of bitly's brand.

Implementation would be simple enough:

```ruby
class ShortCode < ActiveRecord::Base
  after_create :generate_short_code!

  URLSAFE_CHARS = '0123456789' +
  'abcdefghijklmnopqrstuvwxyz' +
  'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

  def generate_short_code!
    base = URLSAFE_CHARS.length
    self.short_code = base_encoded_string(self.id)
    self.save
  end

  def base_encoded_string(num, base = URLSAFE_CHARS.length)
    # String representation of number
    char_indices = []

    while num > 0 do
      char_indices << num % base
      num = (num / base).floor
    end

    string_chars = char_indices.reverse.map { |index| URLSAFE_CHARS[index] }
    string_chars.join("")
  end
end
```

These encoded strings could be pregenerated and cached rainbow-table style if performance becomes an issue.

Since recycling codes, even infrequently used ones, breaks the referential integrity of the web it is probably not a good idea to do so unless the content on the end of that link is no longer present.   Probably the only way I would recycle codes is if users had an understanding that codes will expire after a set time unless they are a premium member with 'foreverized' links as a perk or something.  But if I were desperate to reclaim codes I might write some bots to crawl my destinations and cull/reuse the ones pointing to broken pages.

A better option to conserve namespace is to "deduplicate" code generation by only having one shared shortcode per unique url, at least for non-premium or unauthenticated users doing a drive-by visit to my shortening service.  That way if 1500 people want to share the same trending NYTimes article I won't be wasting my namespace giving each of those people their own code.  Unfortunately this would mean per-user click analytics would no longer be possible.  Uniquely generated, trackable urls would have to become a premium feature, or a feature for logged-in users only.  Seems like a reasonable tradeoff, on balance.