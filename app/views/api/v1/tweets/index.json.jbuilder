# frozen_string_literal: true

json.tweets @tweets_paginated, :id, :tweet, :created_at, :updated_at
json.pagination @pagination
