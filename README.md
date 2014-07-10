# Duffel

Fetch your environment settings. Raise errors or set defaults when a setting does not exist.

## Installation

Add this line to your application's Gemfile:

    gem 'duffel'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install duffel

## Usage

Duffel is a simple gem for reading things out of your environment.

You have something in your environment named `SUPER_SECRET_PASSWORD`? No problem. To get it out, just do the following:

    Duffel.super_secret_password

Simple, right? But why add a layer of abstraction here? Well, there are a few reasons:

Most people get their environment variables like so: `ENV['SUPER_SECRET_PASSWORD']`. This will return nil if the variable is not found. Duffel will return a KeyError, so you are told about missing things.

*But I don't want it to raise an exception!*

That's fine too, you can specify a fallback for Duffel in case something isn't found. Example:

    Duffel.super_secret_password(fallback: 'another-password')

*What if I want to just return nil if it's not found?*

No problem, we can set our fallback to nil:

    Duffel.super_secret_password(fallback: nil)

*What about other settings I might have?*

I actually started writing this because I noticed was using a combination of `ENV['SOME_VARIABLE_NAME_HERE']` and `Settings.some_method_name`. I wanted to just use the `Settings.method_name` pattern everywhere, so I wrote Duffel.

So while Duffel by default gets things out of your environment, you can use it as a general purpose settings drawer.

Let's say you wanted to actually have a constant called Settings in Duffel. You could do something like this:

    class Settings < Duffel

      def self.some_other_awesome_setting
        'awesome setting return value'
      end
    end

Calling `Settings.env_variable_name` will still return you your environment variable, should it exist.

*Duffel is a stupid name*

I know.  

*Why did you do it this way and not this [obviously better way]*

Because I probably don't know the obviously better way. Feel free to submit a pull request or open an issue and I'll look into it!



## Contributing

1. Fork it ( https://github.com/[my-github-username]/duffel/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
