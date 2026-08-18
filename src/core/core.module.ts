import { Module } from "@nestjs/common";
import { PrismaModule } from "./database/prisma.module";
import { TokenModule } from "./token/token.module";
import { AppConfigModule } from "./config/config.module";
import { LoggerModule } from "./logger/logger.module";
@Module({
    imports: [PrismaModule, AppConfigModule, TokenModule, LoggerModule],
    exports: [PrismaModule, AppConfigModule, TokenModule, LoggerModule],
})

export class CoreModule { }