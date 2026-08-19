import { IsEmail, IsNotEmpty, IsString, Min, Max } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { Role } from 'generated/prisma/client';
export class RegisterDto {
    @ApiProperty({ description: 'Username of the user', example: 'john_doe' })
    @IsString()
    @IsNotEmpty()
    username: string;

    @ApiProperty({ description: 'Email of the user', example: 'john.doe@example.com' })
    @IsString()
    @IsEmail()
    @IsNotEmpty()
    email: string;

    @ApiProperty({ description: 'Password of the user', example: 'password123' })
    @IsString()
    @IsNotEmpty()
    @Min(8)
    passwordHash: string;

    @ApiProperty({ description: 'Role of the user', example: 'user' })
    @IsString()
    role: Role;

    @ApiProperty({ description: 'Phone number of the user', example: '+1234567890' })
    @Max(20)
    phoneNumber: string;
}