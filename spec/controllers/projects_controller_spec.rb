#encoding:utf-8
require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  before{ allow(controller).to receive(:current_user).and_return(current_user) }
  before{ ENV['BASE_URL'] = 'http://catarse.me' }
  before{ ENV['EMAIL_PROJECTS'] = 'foo@bar.com' }
  render_views
  subject{ response }
  let(:project){ create(:project, state: 'draft') }
  let(:current_user){ nil }

  describe "POST create" do
    let(:project){ build(:project, state: 'draft') }
    before do
      post :create, { locale: :en, project: project.attributes }
    end

    context "when no user is logged in" do
      it{ is_expected.to redirect_to new_user_registration_path }
    end

    context "when user is logged in" do
      let(:current_user){ create(:user) }
      it{ is_expected.to redirect_to edit_project_path(Project.last, anchor: 'home') }
    end
  end

  describe "GET publish" do
    let(:project){ create(:project, state: 'approved') }
    let(:current_user) { project.user }

    before do
      current_user.update_attributes({
        address_city: 'foo',
        address_state: 'MG',
        address_street: 'bar',
        address_number: '123',
        address_neighbourhood: 'MMs',
        address_zip_code: '000000',
        phone_number: '33344455333'
      })
      create(:reward, project: project)
      create(:bank_account, user: current_user)
      get :publish, id: project.id, locale: :en
      project.reload
    end

    it { expect(project.online?).to eq(true) }
  end

  describe "GET send_to_analysis" do
    let(:current_user){ project.user }

    context "without referal link" do
      before do
        create(:reward, project: project)
        get :send_to_analysis, id: project.id, locale: :en
        project.reload
      end

      it { expect(project.in_analysis?).to eq(true) }
    end

    context "with referal link" do
      subject { project.referal_link }
      before do
        create(:reward, project: project)
        get :send_to_analysis, id: project.id, locale: :en, ref: 'referal'
        project.reload
      end

      it { is_expected.to eq('referal') }
    end
  end

  describe "GET index" do
    before do
      get :index, locale: :en
    end
    it { is_expected.to be_success }

    context "with referal link" do
      subject { controller.session[:referal_link] }

      before do
        get :index, locale: :en, ref: 'referal'
      end

      it { is_expected.to eq('referal') }
    end
  end

  describe "GET new" do
    before { get :new, locale: :en }

    context "when user is a guest" do
      it { is_expected.not_to be_success }
    end

    context "when user is a registered user" do
      let(:current_user){ create(:user, admin: false) }
      it { is_expected.to be_success }
    end
  end

  describe "PUT update" do
    shared_examples_for "updatable project" do
      context "with tab anchor" do
        before { put :update, id: project.id, project: { name: 'My Updated Title' },locale: :en , anchor: 'basics'}

        it{ is_expected.to redirect_to edit_project_path(project, anchor: 'basics') }
      end

      context "with valid permalink" do
        before { put :update, id: project.id, project: { name: 'My Updated Title' },locale: :en }
        it {
          project.reload
          expect(project.name).to eq('My Updated Title')
        }

        it{ is_expected.to redirect_to edit_project_path(project, anchor: 'home') }
      end
    end

    shared_examples_for "protected project" do
      before { put :update, id: project.id, project: { name: 'My Updated Title' },locale: :en }
      it {
        project.reload
        expect(project.name).to eq('Foo bar')
      }
    end

    context "when user is a guest" do
      it_should_behave_like "protected project"
    end

    context "when user is a project owner" do
      let(:current_user){ project.user }

      context "when project is offline" do
        it_should_behave_like "updatable project"
      end

      context "when project is online" do
        let(:project) { create(:project, state: 'online') }

        before do
          allow(controller).to receive(:current_user).and_return(project.user)
        end

        context "when I try to update the project name and the about field" do
          before{ put :update, id: project.id, project: { name: 'new_title', about: 'new_description' }, locale: :en }
          it "should not update title" do
            project.reload
            expect(project.name).not_to eq('new_title')
          end
        end

        context "when I try to update only the about field" do
          before{ put :update, id: project.id, project: { about: 'new_description' }, locale: :en }
          it "should update it" do
            project.reload
            expect(project.about).to eq('new_description')
          end
        end
      end
    end

    context "when user is a registered user" do
      let(:current_user){ create(:user, admin: false) }
      it_should_behave_like "protected project"
    end

    context "when user is an admin" do
      let(:current_user){ create(:user, admin: true) }
      it_should_behave_like "updatable project"
    end
  end

  describe "GET embed" do
    before do
      get :embed, id: project, locale: :en
    end
    its(:status){ should == 200 }
  end

  describe "GET show" do
    context "when we have update_id in the querystring" do
      let(:project){ create(:project) }
      let(:project_post){ create(:project_post, project: project) }
      before{ get :show, permalink: project.permalink, project_post_id: project_post.id, locale: :en }
      it("should assign update to @update"){ expect(assigns(:post)).to eq(project_post) }
    end
  end

  describe "GET video" do
    context 'url is a valid video' do
      let(:video_url){ 'http://vimeo.com/17298435' }
      before do
        allow(VideoInfo).to receive(:get).and_return({video_id: 'abcd'})
        get :video, locale: :en, url: video_url
      end

      its(:body){ should == VideoInfo.get(video_url).to_json }
    end

    context 'url is not a valid video' do
      before { get :video, locale: :en, url: 'http://????' }

      its(:body){ should == nil.to_json }
    end
  end
end
