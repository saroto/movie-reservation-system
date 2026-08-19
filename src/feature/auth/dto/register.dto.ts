import { IsEmail, IsNotEmpty, IsString, Min, Max } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
export class RegisterDto {
    @ApiProperty({ description: 'Username of the user', example: 'john_doe' })
    @IsString()
    @IsNotEmpty()
    username: string;

    @IsString()
    @IsEmail()
    @IsNotEmpty()
    email: string;

    @IsString()
    @IsNotEmpty()
    @Min(8)
    password: string;

    @IsString()
    role: string;

    @Max(20)
    phoneNumber: string;
}