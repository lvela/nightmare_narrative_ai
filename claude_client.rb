# frozen_string_literal: true

require 'httparty'
require 'json'

class ClaudeClient
  def initialize(api_key)
    @api_key = api_key
  end

  def send(prompt)
    body = {
      messages: [{ role: 'user', content: prompt }],
      model: 'claude-3-sonnet-20240229',
      max_tokens: 1000,
      temperature: 0.7
    }

    response = HTTParty.post(
      'https://api.anthropic.com/v1/messages',
      headers:,
      body: body.to_json
    )

    raise "Claude API error: #{response.code} - #{response.body}" unless response.success?

    JSON.parse(response.body)['content'][0]['text']
  end

  private

  def headers
    {
      'x-api-key': @api_key,
      'anthropic-version': '2023-06-01',
      'content-type': 'application/json'
    }
  end
end