# encoding: UTF-8
require 'net/http'
require 'uri'

module Tray
  module Checkout
    class WebService
      def request!(url, params)
        uri = URI.parse(url)
        http = build_http(uri)
        request = build_request(uri, params)

        response = http.request(request)
        response.body
      end

      private

      def build_http(uri)
        http = Net::HTTP.new(uri.host, uri.port)
        http.open_timeout = Tray::Checkout.request_timeout
        http
      end

      def build_request(uri, params)
        request = Net::HTTP::Post.new(uri.path)
        request.set_form_data(params)
        request
      end
    end
  end
end
