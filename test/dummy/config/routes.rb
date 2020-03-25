# frozen_string_literal: true

Rails.application.routes.draw do
  mount Scintilla::Engine => '/scintilla'
end
