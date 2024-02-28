Figo Athallah<br>
2006533571<br>
Tutorial 3 Game Development

## Latihan Mandiri: Eksplorasi Mekanika Pergerakan

**Double Jump**<br>

-   Dapat dilakukan dengan menekan tombol atas (W atau up arrow key) saat sedang berada di udara setelah melompat satu kali. Mekanisme ini ditangani dengan sebuah boolean `doubleJump` (default: false) yang apabila true akan memungkinkan kita untuk meloncat untuk kedua kalinya selama masih di udara. Boolean `doubleJump` tersebut akan menjadi false kembali setelah loncatan kedua tersebut dieksekusi.

**Dashing**<br>

-   Dapat dilakukan dengan menekan tombol directional kiri atau kanan sebanyak dua kali (_double tap_) dalam timeframe tertentu. Hal ini dapat terwujud dengan adanya sebuah variable `DELAY` yang menandakan apabila penekanan tombol dua kali yang kita lakukan adalah sebuah _double tap_ atau bukan. Setelah ditekan sekali, jika tombol ditekan untuk kedua kalinya pada jangka waktu yang lebih pendek atau sama dengan dari `DELAY` yang ditentukan, maka _double tap_ akan terjadi dan speed pemain akan menjadi 2 kali lebih cepat untuk beberapa detik, mengeksekusi mekanika _dash_.

**Crouching**<br>

-   Dapat dilakukan dengan menekan tombol directional bawah. Sprite pemain akan terlihat sedang jongkok sebagai indikasi bahwa kita berhasil _crouch_. Meskipun tidak ada sprite pemain bergerak saat jongkok, tetap ada simulasi bahwa dalam kondisi ini, pemain akan bergerak dengan speed yang 2 kali lebih lambat dari semestinya, diwujudkan oleh sebuah boolean `isCrouched` yang mengecek apabila player sedang menekan tombol bawah saat berjalan atau tidak.

**Fast Reset**<br>

-   Cukup jelas dengan sendirinya, dapat dilakukan dengan menekan key “R” di keyboard yang akan meng-_reset_ level. Berguna jika pemain tidak sengaja keluar dari level dan tidak bisa balik lagi ke atas. Hal yang terjadi di dalam adalah _input key press_ tersebut akan memanggil _tree_ dari scene kita dan melakukan reload agar keadaan level kembali menjadi semula.

**Animated Sprites**<br>

-   Tiap action yang dilakukan pemain memiliki sprite yang sesuai melalui fitur `AnimatedSprite` dan `SpriteFrames`. Ada 4 `SpriteFrames` yang dibuat, yaitu:
    -   **idle**: Default pose ketika player sedang tidak melakukan apa-apa.
    -   **walk_right**: Animasi yang dimainkan ketika player berjalan ke kanan. Untuk kondisi jika player berjalan/menengok ke kiri, dilakukan sebuah _horizontal flip_, cara aktivasinya melalui sebuah boolean check yang akan true apabila `velocity.x` kita kurang dari 0, alias gerakan kita menuju ke kiri.
    -   **jump**: Animasi yang dimainkan ketika player melompat dan akan otomatis berhenti apabila kita sudah mulai jatuh.
    -   **crouch**: Animasi yang dimainkan ketika player berjongkok.
