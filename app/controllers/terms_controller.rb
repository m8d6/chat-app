class TermsController < ApplicationController
  allow_unauthenticated_access

  def show
    respond_to do |format|
      format.turbo_stream
      format.html # İsteğe bağlı: HTML formatı için normal görünüm
    end
  end
end 