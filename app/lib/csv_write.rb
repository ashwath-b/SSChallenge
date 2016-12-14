module CsvWrite

  def self.write_csv(email, ip, subject, type)
    @file = "tmp/suppressed.csv"
    CSV.open(@file, "a") do |csv|
      csv << [email, ip, subject, type]
      csv << ["------------------------------------------------------------------------------------------"]
    end
  end
end
