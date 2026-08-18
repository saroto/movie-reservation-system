-- CreateEnum
CREATE TYPE "Role" AS ENUM ('user', 'admin');

-- CreateEnum
CREATE TYPE "ShowtimeStatus" AS ENUM ('scheduled', 'cancelled');

-- CreateEnum
CREATE TYPE "ReservationStatus" AS ENUM ('pending', 'confirmed', 'cancelled', 'expired');

-- CreateEnum
CREATE TYPE "PaymentStatus" AS ENUM ('pending', 'succeeded', 'failed', 'refunded');

-- CreateTable
CREATE TABLE "users" (
    "user_id" BIGSERIAL NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "password_hash" TEXT NOT NULL,
    "username" VARCHAR(50),
    "phone_number" VARCHAR(20),
    "role" "Role" NOT NULL DEFAULT 'user',
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "users_pkey" PRIMARY KEY ("user_id")
);

-- CreateTable
CREATE TABLE "refresh_token" (
    "token_id" BIGSERIAL NOT NULL,
    "user_id" BIGINT NOT NULL,
    "token_hash" VARCHAR(64) NOT NULL,
    "is_revoked" BOOLEAN NOT NULL DEFAULT false,
    "revoked_at" TIMESTAMPTZ,
    "expires_at" TIMESTAMPTZ NOT NULL,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "refresh_token_pkey" PRIMARY KEY ("token_id")
);

-- CreateTable
CREATE TABLE "genre" (
    "genre_id" SERIAL NOT NULL,
    "genre_name" VARCHAR(50) NOT NULL,
    "description" TEXT,

    CONSTRAINT "genre_pkey" PRIMARY KEY ("genre_id")
);

-- CreateTable
CREATE TABLE "movie" (
    "movie_id" SERIAL NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "poster_img_url" VARCHAR(500),
    "description" TEXT,
    "duration" INTEGER NOT NULL,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "movie_pkey" PRIMARY KEY ("movie_id")
);

-- CreateTable
CREATE TABLE "movie_genre" (
    "movie_id" INTEGER NOT NULL,
    "genre_id" INTEGER NOT NULL,

    CONSTRAINT "movie_genre_pkey" PRIMARY KEY ("movie_id","genre_id")
);

-- CreateTable
CREATE TABLE "cinema" (
    "cinema_id" SERIAL NOT NULL,
    "cinema_name" VARCHAR(100) NOT NULL,
    "address" TEXT,
    "city" VARCHAR(100),
    "timezone" VARCHAR(50) NOT NULL DEFAULT 'UTC',
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "cinema_pkey" PRIMARY KEY ("cinema_id")
);

-- CreateTable
CREATE TABLE "hall" (
    "hall_id" SERIAL NOT NULL,
    "cinema_id" INTEGER NOT NULL,
    "hall_name" VARCHAR(50) NOT NULL,

    CONSTRAINT "hall_pkey" PRIMARY KEY ("hall_id")
);

-- CreateTable
CREATE TABLE "seat_type" (
    "seat_type_id" SERIAL NOT NULL,
    "type_name" VARCHAR(30) NOT NULL,
    "price_modifier" DECIMAL(10,2) NOT NULL DEFAULT 0,

    CONSTRAINT "seat_type_pkey" PRIMARY KEY ("seat_type_id")
);

-- CreateTable
CREATE TABLE "seat" (
    "seat_id" BIGSERIAL NOT NULL,
    "hall_id" INTEGER NOT NULL,
    "seat_type_id" INTEGER NOT NULL,
    "row_letter" VARCHAR(2) NOT NULL,
    "seat_number" INTEGER NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "seat_pkey" PRIMARY KEY ("seat_id")
);

-- CreateTable
CREATE TABLE "showtime" (
    "showtime_id" BIGSERIAL NOT NULL,
    "hall_id" INTEGER NOT NULL,
    "movie_id" INTEGER NOT NULL,
    "start_time" TIMESTAMPTZ NOT NULL,
    "end_time" TIMESTAMPTZ NOT NULL,
    "base_price" DECIMAL(10,2) NOT NULL,
    "status" "ShowtimeStatus" NOT NULL DEFAULT 'scheduled',
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "showtime_pkey" PRIMARY KEY ("showtime_id")
);

-- CreateTable
CREATE TABLE "reservation" (
    "reservation_id" BIGSERIAL NOT NULL,
    "user_id" BIGINT NOT NULL,
    "showtime_id" BIGINT NOT NULL,
    "total_price" DECIMAL(10,2) NOT NULL,
    "status" "ReservationStatus" NOT NULL DEFAULT 'pending',
    "hold_expires_at" TIMESTAMPTZ,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "reservation_pkey" PRIMARY KEY ("reservation_id")
);

-- CreateTable
CREATE TABLE "reservation_seat" (
    "ticket_id" BIGSERIAL NOT NULL,
    "reservation_id" BIGINT NOT NULL,
    "showtime_id" BIGINT NOT NULL,
    "seat_id" BIGINT NOT NULL,
    "hall_id" INTEGER NOT NULL,
    "price_at_purchase" DECIMAL(10,2) NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "reservation_seat_pkey" PRIMARY KEY ("ticket_id")
);

-- CreateTable
CREATE TABLE "payment" (
    "payment_id" BIGSERIAL NOT NULL,
    "reservation_id" BIGINT NOT NULL,
    "amount" DECIMAL(10,2) NOT NULL,
    "currency" CHAR(3) NOT NULL DEFAULT 'USD',
    "status" "PaymentStatus" NOT NULL DEFAULT 'pending',
    "provider" VARCHAR(50) NOT NULL,
    "provider_txn_id" VARCHAR(255),
    "paid_at" TIMESTAMPTZ,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "payment_pkey" PRIMARY KEY ("payment_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "users_username_key" ON "users"("username");

-- CreateIndex
CREATE UNIQUE INDEX "refresh_token_token_hash_key" ON "refresh_token"("token_hash");

-- CreateIndex
CREATE INDEX "refresh_token_user_id_idx" ON "refresh_token"("user_id");

-- CreateIndex
CREATE INDEX "refresh_token_expires_at_idx" ON "refresh_token"("expires_at");

-- CreateIndex
CREATE UNIQUE INDEX "genre_genre_name_key" ON "genre"("genre_name");

-- CreateIndex
CREATE INDEX "movie_genre_genre_id_idx" ON "movie_genre"("genre_id");

-- CreateIndex
CREATE UNIQUE INDEX "hall_cinema_id_hall_name_key" ON "hall"("cinema_id", "hall_name");

-- CreateIndex
CREATE UNIQUE INDEX "seat_type_type_name_key" ON "seat_type"("type_name");

-- CreateIndex
CREATE UNIQUE INDEX "seat_hall_id_row_letter_seat_number_key" ON "seat"("hall_id", "row_letter", "seat_number");

-- CreateIndex
CREATE UNIQUE INDEX "uq_seat_hall" ON "seat"("seat_id", "hall_id");

-- CreateIndex
CREATE INDEX "showtime_hall_id_start_time_idx" ON "showtime"("hall_id", "start_time");

-- CreateIndex
CREATE INDEX "showtime_movie_id_idx" ON "showtime"("movie_id");

-- CreateIndex
CREATE INDEX "showtime_start_time_idx" ON "showtime"("start_time");

-- CreateIndex
CREATE UNIQUE INDEX "uq_showtime_hall" ON "showtime"("showtime_id", "hall_id");

-- CreateIndex
CREATE INDEX "reservation_user_id_idx" ON "reservation"("user_id");

-- CreateIndex
CREATE INDEX "reservation_showtime_id_idx" ON "reservation"("showtime_id");

-- CreateIndex
CREATE INDEX "reservation_status_hold_expires_at_idx" ON "reservation"("status", "hold_expires_at");

-- CreateIndex
CREATE UNIQUE INDEX "uq_reservation_showtime" ON "reservation"("reservation_id", "showtime_id");

-- CreateIndex
CREATE INDEX "reservation_seat_reservation_id_idx" ON "reservation_seat"("reservation_id");

-- CreateIndex
CREATE INDEX "reservation_seat_showtime_id_seat_id_idx" ON "reservation_seat"("showtime_id", "seat_id");

-- CreateIndex
CREATE UNIQUE INDEX "payment_provider_txn_id_key" ON "payment"("provider_txn_id");

-- CreateIndex
CREATE INDEX "payment_reservation_id_idx" ON "payment"("reservation_id");

-- AddForeignKey
ALTER TABLE "refresh_token" ADD CONSTRAINT "refresh_token_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "movie_genre" ADD CONSTRAINT "movie_genre_movie_id_fkey" FOREIGN KEY ("movie_id") REFERENCES "movie"("movie_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "movie_genre" ADD CONSTRAINT "movie_genre_genre_id_fkey" FOREIGN KEY ("genre_id") REFERENCES "genre"("genre_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "hall" ADD CONSTRAINT "hall_cinema_id_fkey" FOREIGN KEY ("cinema_id") REFERENCES "cinema"("cinema_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "seat" ADD CONSTRAINT "seat_hall_id_fkey" FOREIGN KEY ("hall_id") REFERENCES "hall"("hall_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "seat" ADD CONSTRAINT "seat_seat_type_id_fkey" FOREIGN KEY ("seat_type_id") REFERENCES "seat_type"("seat_type_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "showtime" ADD CONSTRAINT "showtime_hall_id_fkey" FOREIGN KEY ("hall_id") REFERENCES "hall"("hall_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "showtime" ADD CONSTRAINT "showtime_movie_id_fkey" FOREIGN KEY ("movie_id") REFERENCES "movie"("movie_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reservation" ADD CONSTRAINT "reservation_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reservation" ADD CONSTRAINT "reservation_showtime_id_fkey" FOREIGN KEY ("showtime_id") REFERENCES "showtime"("showtime_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reservation_seat" ADD CONSTRAINT "reservation_seat_reservation_id_showtime_id_fkey" FOREIGN KEY ("reservation_id", "showtime_id") REFERENCES "reservation"("reservation_id", "showtime_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "reservation_seat" ADD CONSTRAINT "reservation_seat_seat_id_hall_id_fkey" FOREIGN KEY ("seat_id", "hall_id") REFERENCES "seat"("seat_id", "hall_id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "reservation_seat" ADD CONSTRAINT "reservation_seat_showtime_id_hall_id_fkey" FOREIGN KEY ("showtime_id", "hall_id") REFERENCES "showtime"("showtime_id", "hall_id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "payment" ADD CONSTRAINT "payment_reservation_id_fkey" FOREIGN KEY ("reservation_id") REFERENCES "reservation"("reservation_id") ON DELETE RESTRICT ON UPDATE CASCADE;
