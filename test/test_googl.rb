require 'helper'

class TestGoogl < Test::Unit::TestCase
  context "googl-api module" do
      should "create a new googl-api client" do
        c = GooglApi.new(api_key)
        assert_equal GooglApi::Client, c.class
      end
    end
    context "using the googl-api client" do
      setup do
        @client = GooglApi.new(api_key)
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
            assert_equal "http://goo.gl/p2Jpa", @url.short_url
          end
          should "save the long url" do
            assert_equal "http://ruby-lang.org/", @url.long_url
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

end
