import { Module } from "@nestjs/common";
import { TokenService } from "./token.service";
import { JwtModule } from "@nestjs/jwt";
import { AppConfigModule } from "../config/config.module";

@Module({
    providers: [TokenService],
    exports: [TokenService],
    imports: [JwtModule, AppConfigModule]
})

export class TokenModule { }