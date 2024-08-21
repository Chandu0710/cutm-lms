document.addEventListener('DOMContentLoaded', function () {
    const storedAvatar = localStorage.getItem('userAvatar');
    if (storedAvatar) {
        const avatarImages = document.querySelectorAll('.user-avatar');
        avatarImages.forEach((avatar) => {
            avatar.src = storedAvatar;
        });
    }
});





