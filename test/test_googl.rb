require 'helper'

class TestGoogl < Test::Unit::TestCase
  context "googl-api module" do
      should "create a new googl-api client" do
        c = GooglApi.new(:api_key => api_key)
        assert_equal GooglApi::Client, c.class
      end
    end
    context "using the googl-api client" do
      setup do
        @client = GooglApi.new(:api_key => api_key)
      end

      context "shortening" do
        context "a single link" do
          setup do
            @url = @client.shorten('http://ruby-lang.org/')
          end
          should "return a GooglApi::Response" do
            assert_kind_of GooglApi::Response, @url
          end
          should "return a short goo.gl url" do
            assert @url.short_url.match(/^http:\/\/goo.gl\//)
          end
          should "save the long url" do
            assert_equal "http://ruby-lang.org/", @url.long_url
          end
          should "provide a qr code url" do
            assert_equal @url.short_url, @url.qr_code[0..(@url.short_url.size - 1)]
          end
        end
        context "no links" do
          should "raise an ArgumentError" do
            assert_raise ArgumentError do
              @client.shorten
            end
          end
        end
      end
      context "expanding" do
        context "a short bitly url" do
          setup do
            @url = @client.expand("http://goo.gl/p2Jpa")
          end
          should "return a GooglApi::Response" do
            assert_kind_of GooglApi::Response, @url
          end
          should "return the expanded url" do
            assert_equal "http://ruby-lang.org/", @url.long_url
          end
          should "save the bitly url" do
            assert_equal "http://goo.gl/p2Jpa", @url.short_url
          end
        end
        context "no links" do
          should "raise an ArgumentError" do
            assert_raise ArgumentError do
              @client.shorten
            end
          end
        end
      end
      context "to get analytics on" do
        context "a single link" do
          setup do
            @url = @client.analytics("http://goo.gl/p2Jpa")
          end
          should "return a GooglApi::Response" do
            assert_kind_of GooglApi::Response, @url
          end
          should "return a response object with analytics data" do
            assert_not_nil @url.analytics
          end
        end
      end
      context "no links" do
        should "raise an ArgumentError" do
          assert_raise ArgumentError do
            @client.shorten
          end
        end
      end
    end
    context "using the googl-api client without api key" do
      setup do
        @client = GooglApi.new
      end

      context "shortening" do
        context "a single link" do
          setup do
            @url = @client.shorten('http://ruby-lang.org/')
          end
          should "return a GooglApi::Response" do
            assert_kind_of GooglApi::Response, @url
          end
        end
      end
      context "history" do
        should "raise an ArgumentError because auth is not set" do
          assert_raise ArgumentError do
            @client.history
          end
        end
      end
    end
    context "using google client login" do
      setup do
        @client_auth = GooglApi.new(:email => email, :password => password)
      end
      
      context "shortening" do
        context "a single link" do
          setup do
            @url = @client_auth.shorten('http://ruby-lang.org/')
          end
          should "return a GooglApi::Response" do
            assert_kind_of GooglApi::Response, @url
          end
        end
      end
      context "history" do
        should "have history" do 
          assert_not_nil @client_auth.history
        end
      end
    end
end
