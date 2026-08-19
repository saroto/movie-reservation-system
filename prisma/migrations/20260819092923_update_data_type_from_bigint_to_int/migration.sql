/*
  Warnings:

  - The primary key for the `payment` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `payment_id` on the `payment` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.
  - You are about to alter the column `reservation_id` on the `payment` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.
  - The primary key for the `refresh_token` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `token_id` on the `refresh_token` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.
  - You are about to alter the column `user_id` on the `refresh_token` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.
  - The primary key for the `reservation` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `reservation_id` on the `reservation` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.
  - You are about to alter the column `user_id` on the `reservation` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.
  - You are about to alter the column `showtime_id` on the `reservation` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.
  - The primary key for the `reservation_seat` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `ticket_id` on the `reservation_seat` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.
  - You are about to alter the column `reservation_id` on the `reservation_seat` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.
  - You are about to alter the column `showtime_id` on the `reservation_seat` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.
  - You are about to alter the column `seat_id` on the `reservation_seat` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.
  - The primary key for the `seat` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `seat_id` on the `seat` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.
  - The primary key for the `showtime` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `showtime_id` on the `showtime` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.
  - The primary key for the `users` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `user_id` on the `users` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.

*/
-- DropForeignKey
ALTER TABLE "payment" DROP CONSTRAINT "payment_reservation_id_fkey";

-- DropForeignKey
ALTER TABLE "refresh_token" DROP CONSTRAINT "refresh_token_user_id_fkey";

-- DropForeignKey
ALTER TABLE "reservation" DROP CONSTRAINT "reservation_showtime_id_fkey";

-- DropForeignKey
ALTER TABLE "reservation" DROP CONSTRAINT "reservation_user_id_fkey";

-- DropForeignKey
ALTER TABLE "reservation_seat" DROP CONSTRAINT "reservation_seat_reservation_id_showtime_id_fkey";

-- DropForeignKey
ALTER TABLE "reservation_seat" DROP CONSTRAINT "reservation_seat_seat_id_hall_id_fkey";

-- DropForeignKey
ALTER TABLE "reservation_seat" DROP CONSTRAINT "reservation_seat_showtime_id_hall_id_fkey";

-- AlterTable
ALTER TABLE "payment" DROP CONSTRAINT "payment_pkey",
ALTER COLUMN "payment_id" SET DATA TYPE SERIAL,
ALTER COLUMN "reservation_id" SET DATA TYPE INTEGER,
ADD CONSTRAINT "payment_pkey" PRIMARY KEY ("payment_id");

-- AlterTable
ALTER TABLE "refresh_token" DROP CONSTRAINT "refresh_token_pkey",
ALTER COLUMN "token_id" SET DATA TYPE SERIAL,
ALTER COLUMN "user_id" SET DATA TYPE INTEGER,
ADD CONSTRAINT "refresh_token_pkey" PRIMARY KEY ("token_id");

-- AlterTable
ALTER TABLE "reservation" DROP CONSTRAINT "reservation_pkey",
ALTER COLUMN "reservation_id" SET DATA TYPE SERIAL,
ALTER COLUMN "user_id" SET DATA TYPE INTEGER,
ALTER COLUMN "showtime_id" SET DATA TYPE INTEGER,
ADD CONSTRAINT "reservation_pkey" PRIMARY KEY ("reservation_id");

-- AlterTable
ALTER TABLE "reservation_seat" DROP CONSTRAINT "reservation_seat_pkey",
ALTER COLUMN "ticket_id" SET DATA TYPE SERIAL,
ALTER COLUMN "reservation_id" SET DATA TYPE INTEGER,
ALTER COLUMN "showtime_id" SET DATA TYPE INTEGER,
ALTER COLUMN "seat_id" SET DATA TYPE INTEGER,
ADD CONSTRAINT "reservation_seat_pkey" PRIMARY KEY ("ticket_id");

-- AlterTable
ALTER TABLE "seat" DROP CONSTRAINT "seat_pkey",
ALTER COLUMN "seat_id" SET DATA TYPE SERIAL,
ADD CONSTRAINT "seat_pkey" PRIMARY KEY ("seat_id");

-- AlterTable
ALTER TABLE "showtime" DROP CONSTRAINT "showtime_pkey",
ALTER COLUMN "showtime_id" SET DATA TYPE SERIAL,
ADD CONSTRAINT "showtime_pkey" PRIMARY KEY ("showtime_id");

-- AlterTable
ALTER TABLE "users" DROP CONSTRAINT "users_pkey",
ALTER COLUMN "user_id" SET DATA TYPE SERIAL,
ADD CONSTRAINT "users_pkey" PRIMARY KEY ("user_id");

-- AddForeignKey
ALTER TABLE "refresh_token" ADD CONSTRAINT "refresh_token_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

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
