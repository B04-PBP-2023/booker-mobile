# Booker
[![Build status](https://build.appcenter.ms/v0.1/apps/4e747ad8-afd3-4acf-bb96-3eb36ed692a8/branches/main/badge)](https://appcenter.ms)
![Staging](https://github.com/B04-PBP-2023/booker-mobile/actions/workflows/staging.yml/badge.svg)
![Pre-release](https://github.com/B04-PBP-2023/booker-mobile/actions/workflows/pre-release.yml/badge.svg)
![Release](https://github.com/B04-PBP-2023/booker-mobile/actions/workflows/release.yml/badge.svg)

[Tautan untuk mengunduh apikasi](https://install.appcenter.ms/orgs/b04-pbp-2023/apps/booker/distribution_groups/public)

[Berita acara](https://1drv.ms/x/s!Ar5Hb9gKjcO7hcdg0luy9o4mG9s4gg?e=d1LLew)

Booker adalah aplikasi _mobile_ untuk meminjam, mendonasikan, dan membeli buku. Aplikasi _mobile_ ini dilengkapi dengan sistem poin yang bisa didapatkan ketika meminjam, melakukan review, serta mendonasikan buku. Poin tersebut dapat ditukarkan dengan buku gratis. Dengan sistem ini, diharapkan pengguna semakin termotivasi untuk membaca buku, dan membantu meningkatkan literasi masyarakat Indonesia.

## Nama Anggota Kelompok

1. Ahmad Fatih Faizi

2. Sandria Rania Isanura

3. Rashif Aunur Rasyid

4. Nasywa Kamila Az Zahra

5. Mahesa Farih Prasetyo

6. Muhammad Rafi Zia Ulhaq

## Daftar Modul

1. Front Page

    Tampilan awal aplikasi, di mana pengguna dapat melihat koleksi buku-buku yang tersedia, dan mencari buku.

2. Pinjam buku

    Pengguna dapat meminjam buku. Buku yang dipinjam dapat diakses di bookshelf masing-masing pengguna. Setiap buku yang telah selesai masa pinjamnya, akan otomatis dikembalikan. Ketika pengguna mengembalikan buku, pengguna akan mendapatkan poin yang dapat ditukar dengan buku.

3. Beli buku (Toko Buku)

    Pengguna dapat membeli buku. Buku yang telah dibeli dapat diakses di bookshelf masing-masing pengguna. Pengguna juga dapat menggunakan poin yang diperoleh dari meminjam buku atau donasi untuk membeli buku.

4. Bookshelf

    Bookshelf menyimpan dan memungkinkan pengguna mengakses semua buku yang telah dibeli dan/atau sedang dipinjam oleh pengguna.

5. Donasi buku

    Pengguna dapat mendonasikan buku. Setiap buku yang didonasikan, pengguna akan mendapat poin yang dapat ditukarkan dengan buku di Toko Buku. Buku yang telah didonasikan, akan tersedia untuk dipinjam oleh pengguna lain.

6. Review buku

    Pengguna yang sudah pernah meminjam/membeli buku, dapat memberikan ulasan untuk buku tersebut. Setiap pengguna memberi ulasan, pengguna akan mendapatkan poin yang dapat ditukar dengan buku.

7. Laman admin

    Hanya pengguna dengan role Admin dapat mengakses laman ini. Pada laman ini, terdapat fitur untuk cek stok buku untuk peminjaman dan data penjualan buku.
 
## Pembagian Tugas

1. Front page (Tampilan dataset buku)

    Ahmad Fatih Faizi

2. Fitur pinjam buku

    Rashif Aunur Rasyid

3. Fitur beli buku

    Ahmad Fatih Faizi

4. Fitur bookshelf

    Nasywa Kamila Az Zahra

5. Fitur donasi buku

    Mahesa Farih Prasetyo

6. Fitur review buku

    Muhammad Rafi Zia Ulhaq

7. Laman Admin

    Sandria Rania Isanura

## Peran Pengguna Aplikasi

Terdapat tiga (3) role di aplikasi _mobile_ ini, yakni Admin, User, dan Guest.

- Admin

    Admin dapat mengakses laman admin, dan fitur-fitur yang dapat diakses oleh role User.

- User

    User dapat mengakses semua fitur, kecuali laman admin. Untuk mendapatkan role User, pengguna harus melakukan pendaftaran dan login.

- Guest

    Guest adalah role default jika pengguna tidak login. Guest dapat mengakses laman front page, tetapi tidak dapat mengakses bookshelf, dan tidak dapat melakukan peminjaman maupun pembelian buku.

## Alur Pengintegrasian dengan _Web Service_

Secara garis besar, alur pengintegrasian dengan _Web Service_ dibagi menjadi tiga:
  
1. Integrasi Autentikasi Antara Aplikasi _mobile_ dengan Aplikasi _Web_
   1. _Setup_ pada Aplikasi _Web_ Django
   2. _Setup_ pada Aplikasi _mobile_

2. Menerapkan _Fetch Data_ dari Layanan _Web_ untuk Ditampilkan pada Aplikasi _mobile_
   1. Menambahkan dependensi `http`
   2. Melakukan _Fetch Data_ dari Layanan _Web_
       
3. Integrasi _Form Flutter_ dengan Layanan _Web_

   1. Terdapat sebuah fungsi yang akan mengirim data _form_ pada aplikasi _flutter_ dalam bentuk `json` menuju Aplikasi _Web_
   2. Terdapat sebuah fungsi dalam aplikasi Django yang menerima data _form_ dalam bentuk `json` lalu diproses sesuai dengan yang dituju
