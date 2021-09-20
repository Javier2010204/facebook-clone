module ApplicationHelper

    def resource
        @resource ||= User.new
    end

    def resource_name
        :user
    end

    def resource_class
        User
    end

    def user_avatar(user)

        if user.avatar.attached?
            cl_image_tag user.avatar.key
        else
            cl_image_tag("default-profile-image_ajchrk.png")
        end
    end

    def cover_user(user)
        if user.cover.attached?
            url_for(user.cover)
        else
            'default-avatar.jpeg'
        end
    end
    
    
    
end
