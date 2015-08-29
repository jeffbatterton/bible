require "nokogiri"

namespace :import do

  task books: :environment do
    book_name_array = ["Genesis", "Exodus", "Leviticus", "Numbers", "Deuteronomy", "Joshua", "Judges", "Ruth", "1 Samuel", "2 Samuel", "1 Kings", "2 Kings", "1 Chronicles", "2 Chronicles", "Ezra", "Nehemiah", "Esther", "Job", "Psalms", "Proverbs", "Ecclesiastes", "Song of Solomon", "Isaiah", "Jeremiah", "Lamentations", "Ezekiel", "Daniel", "Hosea", "Joel", "Amos", "Obadiah", "Jonah", "Micah", "Nahum", "Habakkuk", "Zephaniah", "Haggai", "Zechariah", "Malachi", "Matthew", "Mark", "Luke", "John", "Acts", "Romans", "1 Corinthians", "2 Corinthians", "Galatians", "Ephesians", "Philippians", "Colossians", "1 Thessalonians", "2 Thessalonians", "1 Timothy", "2 Timothy", "Titus", "Philemon", "Hebrews", "James", "1 Peter", "2 Peter", "1 John", "2 John", "3 John", "Jude", "Revelation"]
    int = 0
    while int < 66 do
      Book.create(:title => book_name_array[int])
      puts "+ #{book_name_array[int]}"
      int += 1
    end
    puts "Done. #{Book.count} books in the database."
  end

  task :verses, [:version] => :environment do |task, args|

    # https://github.com/matt-cook/osis-bibles
    file = File.open("doc/#{args.version}.xml")
    text = Nokogiri::XML(file)

    translation = text.css("identifier").inner_text

    book_number   = 1
    previous_book = "Gen"

    text.css("verse").each do |node|
      osis_id       = node["osisID"]
      book          = osis_id.split(".")[0]
      chapter       = osis_id.split(".")[1]
      verse         = osis_id.split(".")[2]
      body          = node.inner_text

      unless book == previous_book
        previous_book = book
        book_number   += 1
      end

      puts "+ (#{translation}) #{book} #{chapter}:#{verse}"

      Verse.create(:translation => translation, :book_number => book_number, :chapter_number => chapter, :verse_number => verse, :body => body)

    end

    puts "Done. #{Verse.count} verses in the database."

  end

  task :chapters, [:version] => :environment do |task, args|

    # https://github.com/matt-cook/osis-bibles
    file = File.open("doc/#{args.version}.xml")
    text = Nokogiri::XML(file)

    book_number      = 1
    previous_book    = "Gen"
    previous_chapter = 0

    text.css("chapter").each do |node|
      osis_id       = node["osisID"]
      book          = osis_id.split(".")[0]
      chapter       = osis_id.split(".")[1]

      unless book == previous_book
        previous_book = book
        book_number   += 1
      end

      unless chapter == previous_chapter
        previous_chapter = chapter
      end

      puts "+ #{book} #{chapter}"

      Chapter.create(:book_number => book_number, :chapter_number => chapter)

    end

    puts "Done. #{Chapter.count} chapters in the database."

  end

end
