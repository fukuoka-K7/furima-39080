require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "nicknameとemail、passwordとpassword_confirmation、氏名（漢字）、氏名（カタカナ）、生年月日が存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it "nicknameが空では登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it "passwordが空では登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "emailに@が含まれていなければ登録できない" do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it "passwordは5文字以下では登録できない" do
        @user.password = '1234a'
        @user.password_confirmation = '1234a'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが129文字以上では登録できない' do
        @user.password =  Faker::Internet.password(min_length: 129)
        @user.password_confirmation =  @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end
      it "passwordは数字だけでは登録できない" do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it "passwordは英字だけでは登録できない" do
        @user.password = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it "全角を含むパスワードでは登録できない" do
        @user.password = '12345a'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it "passwordとpassword_confirmationが一致していなければ登録できない" do
        @user.password = '12345a'
        @user.password_confirmation = '123456a'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "苗字に半角文字が含まれていると登録できない登録できない" do
        @user.last_name_kanji = 'tanaka'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kanji 全角文字を使用してください")
      end
      it "名前が漢字かひらがなで入力されていなければ登録できない" do
        @user.first_name_kanji = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kanji 全角文字を使用してください")
      end
      it "苗字がカタカナで入力されていなければ登録できない" do
        @user.last_name_kana = 'tanaka'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana 全角(カタカナ)を使用してください")
      end
      it "名前がカタカナで入力されていなければ登録できない" do
        @user.first_name_kana = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana 全角(カタカナ)を使用してください")
      end
      it "苗字(漢字)が空では登録できない" do
        @user.last_name_kanji = ''
        @user.valid?
        expect(@user.errors.full_messages).to include( "Last name kanji 全角文字を使用してください")
      end
      it "名前(漢字)が空では登録できない" do
        @user.first_name_kanji = ''
        @user.valid?
        expect(@user.errors.full_messages).to include( "First name kanji 全角文字を使用してください")
      end
      it "苗字(カタカナ)が空では登録できない" do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana 全角(カタカナ)を使用してください")
      end
      it "名前(カタカナ)が空では登録できない" do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana 全角(カタカナ)を使用してください")
      end
      it "生年月日が空では登録できない" do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
end
end
