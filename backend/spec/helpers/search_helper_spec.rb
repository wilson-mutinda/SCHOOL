require 'rails_helper'
RSpec.describe SearchHelper, type: :helper do
    describe "#unique_stream_name" do
      let(:streams) do
        [
          double(name: 'west'),
          double(name: 'east')
        ]
      end
      it "returns an error if stream already exists" do
        result = helper.unique_stream_name(streams, 'west')
        expect(result).to eq({ 'errors': 'Stream name already exists!'})
      end

      it "passes if name does not exist" do
        result = helper.unique_stream_name(streams, 'north')
        expect(result).to eq('north')
      end
    end

    describe "#search_stream_slug" do
      let(:streams) do
        [
          double(id: 1, name: 'east', slug: 'west'),
          double(id: 2, name: 'west', slug: 'east')
        ]
      end

      it "returns an error if id was not found" do
        result = helper.search_stream_slug(streams, 3)
        expect(result).to eq({ 'errors': "Stream not found for ID 3"})
      end

      it "returns an object if id was found" do
        result = helper.search_stream_slug(streams, 1)
        expect(result).to eq(streams[0])
      end

      it "returns an error if slug not found" do
        result = helper.search_stream_slug(streams, 'wes')
        expect(result).to eq({errors: "Stream not found for wes"})
      end
    end

    describe "#search_unique_name" do
      let(:streams) do
        [
          double(id: 1, name: 'yy'),
          double(id: 2, name: 'zz'),
        ]
      end

      it "returns an error if name alredy exists" do
        result = helper.search_unique_name(streams, 'yy', 3)
        expect(result).to eq({ errors: 'Name already exists!'})
      end

      it "returns name if it does not exist" do
        result = helper.search_unique_name(streams, 'ww', 3)
        expect(result).to eq('ww')
      end
    end

    describe "#unique_level_name" do
      let(:levels) do
        [
          double(id: 1, name: 3),
          double(id: 2, name: 4)
        ]
      end

      it "returns an error if name already exists!" do
        result = helper.unique_level_name(levels, 4)
        expect(result).to eq({ errors: 'This level already exists!'})
      end

      it "returns object if name does not exist" do
        result = helper.unique_level_name(levels,  5)
        expect(result).to eq(5)
      end
    end

    describe "#search_level_slug" do
      let(:levels) do
        [
          double(id: 1, name: 2, slug: "1"),
          double(id: 2, name: 3, slug: "2"),
        ]
      end

      it "returns an error if id is not found" do
        result = helper.search_level_slug(levels, 4)
        expect(result).to eq({ errors: "Level not found for 4"})
      end

      it "returns an object if id and slug were found" do
        result = helper.search_level_slug(levels, 2)
        expect(result).to eq(levels[0])
      end
    end

    describe "#search_unique_level" do
      let(:levels) do
        [
          double(id: 1, name: 3),
          double(id: 2, name: 4),
          double(id: 3, name: 5)
        ]
      end

      it "returns an error if name alredy exists" do
        result = helper.search_unique_level(levels, 3, 4)
        expect(result).to eq({ errors: 'This level already exists!'})
      end

      it "returns an object if name passes" do
        result = helper.search_unique_level(levels, 3, 1)
        expect(result).to eq(3)
      end

      it "returns an name if name does not exist" do
        result = helper.search_unique_level(levels, 6, 4)
        expect(result).to eq(6)
      end
    end

    describe "#search_unique_subject" do
      let(:subjects) do
        [
          double(id: 1, name: 'aa'),
          double(id: 2, name: 'bb'),
          double(id: 3, name: 'cc'),
          double(id: 4, name: 'dd')
        ]
      end

      it "returns an error if name already exists!" do
        result = helper.search_unique_subject(subjects, 'cc')
        expect(result).to eq({ errors: 'Subject already exists!'})
      end

      it "returns an object name if not founnd in the dbase" do
        result = helper.search_unique_subject(subjects, 'ee')
        expect(result).to eq('Ee')
      end
    end

    describe "#search_subject_slug" do
      let(:subjects) do
        [
          double(id: 1, name: 'aa', slug: 'aa'),
          double(id: 2, name: 'bb', slug: 'bb'),
          double(id: 3, name: 'cc', slug: 'cc')
        ]
      end

      it "returns an object if id was found" do
        result = helper.search_subject_slug(subjects, 1)
        expect(result).to eq(subjects[0])
      end

      it "returns an error if ID was not found" do
        result = helper.search_subject_slug(subjects, 4)
        expect(result).to eq({ errors: "Subject not found for ID 4"})
      end

      it "returns an error if name not found" do
        result = helper.search_subject_slug(subjects, 'dd')
        expect(result).to eq({ errors: "Subject not found for #dd"})
      end

      it "returns an object if name was found" do
        result = helper.search_subject_slug(subjects, 'cc')
        expect(result).to eq(subjects[2])
      end
    end

    describe "#search_unique_subject_name" do
      let(:subjects) do
        [
          double(id: 1, name: 'aa'),
          double(id: 2, name: 'bb'),
          double(id: 3, name: 'cc')
        ]
      end

      it "returns an error if name exists" do
        result = helper.search_unique_subject_name(subjects, 'aa', 4)
        expect(result).to eq({ errors: "Name already exists!" })
      end

      it "returns name if its found" do
        result = helper.search_unique_subject_name(subjects, 'bb', 2)
        expect(result).to eq('Bb')
      end
    end

    describe "#unique_email_search" do
      let(:users) do
        [
          double(id: 1, email: "aa@gmail.com"),
          double(id: 2, email: "bb@gmail.com"),
          double(id: 3, email: "cc@gmail.com")
        ]
      end

      it "returns an error if email already exists" do
        result = helper.unique_email_search(users, 'aa@gmail.com')
        expect(result).to eq({ errors: "User with this email already exists!"})
      end

      it "returns email if it does not exist on the list" do
        result = helper.unique_email_search(users, 'dd@gmail.com')
        expect(result).to eq('dd@gmail.com')
      end
    end

    describe "#search_user_by_slug" do
      let(:users) do
        [
          double(id: 1, email: 'aa@gmail.com', phone: '254791738418'),
          double(id: 2, email: "bb@gmail.com", phone: '254748929891')
        ]
      end

      it "returns an error if id is not found" do
        result = helper.search_user_by_slug(users, 5)
        expect(result).to eq({ errors: "User with ID 5 does not exist!"})
      end

      it "returns an object if id was found" do
        result = helper.search_user_by_slug(users, 2)
        expect(result).to eq(users[1])
      end

      it "returns an error if email was not found" do
        result = helper.search_user_by_slug(users, 'bc@gmail.com')
        expect(result).to eq({ errors: "User not found with slug #bc@gmail.com"})
      end

      it "returns a user object if email slug was found" do
        result = helper.search_user_by_slug(users, 'bb@gmail.com')
        expect(result).to eq(users[1])
      end

      it "returns an error if phone was not found" do
        result = helper.search_user_by_slug(users, '254791738417')
        expect(result).to eq({ errors: "User not found with slug #254791738417"})
      end

      it "returns an object on finding user phone" do
        result = helper.search_user_by_slug(users, '254791738418')
        expect(result).to eq(users[0])
      end
    end

    describe "#unique_email" do
      let(:users) do
        [
          double(id: 1, email: 'aa@gmail.com'),
          double(id: 2, email: 'bb@gmail.com')
        ]
      end

      it "returns an error if email has been taken" do
        result = helper.unique_email(users, 'aa@gmail.com', 3)
        expect(result).to eq({ errors: "Email has been taken!"})
      end

      it "returns email param if nit has not been taken" do
        result = helper.unique_email(users, 'cc@gmail.com', 3)
        expect(result).to eq('cc@gmail.com')
      end
    end
end
