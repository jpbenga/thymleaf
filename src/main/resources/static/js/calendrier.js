document.addEventListener('DOMContentLoaded', (event) => {
    const emojiPicker = document.getElementById('emoji-picker');

    document.body.addEventListener('click', (e) => {
        if (e.target.matches('.reagir-btn')) {
            const gifId = e.target.getAttribute('data-gif-id');
            emojiPicker.style.top = `${e.clientY}px`;
            emojiPicker.style.left = `${e.clientX}px`;
            emojiPicker.style.display = 'block';

            if (!emojiPicker.getAttribute('data-listener-attached')) {
                emojiPicker.addEventListener('emoji-picker-emoji-chosen', (event) => {
                    console.log(`Emoji choisi pour le gif ${gifId}: ${event.detail.unicode}`);
                  
                });
                emojiPicker.setAttribute('data-listener-attached', 'true');
            }
        } else {
            emojiPicker.style.display = 'none';
        }
    });
});
