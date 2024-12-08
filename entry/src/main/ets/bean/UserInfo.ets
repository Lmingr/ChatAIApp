import { MessageBean } from "./MessageBean";
import { List } from "@kit.ArkTS";


export class  UserInfo{
  private _uid: number;

  public set uid(value: number) {
    this._uid = value;
  }

  public get uid(): number {
    return this._uid;
  }

  private _username: string;

  public set username(value: string) {
    this._username = value;
  }

  public get username(): string {
    return this._username;
  }

  private _password: string;

  public set password(value: string) {
    this._password = value;
  }

  public get password(): string {
    return this._password;
  }

  private _salt: string;

  public set salt(value: string) {
    this._salt = value;
  }

  public get salt(): string {
    return this._salt;
  }

  private _phone: string;

  public set phone(value: string) {
    this._phone = value;
  }

  public get phone(): string {
    return this._phone;
  }

  private _email: string;

  public set email(value: string) {
    this._email = value;
  }

  public get email(): string {
    return this._email;
  }

  private _avater: string;

  public set avater(value: string) {
    this._avater = value;
  }

  public get avater(): string {
    return this._avater;
  }

  private _gender: string;

  public set gender(value: string) {
    this._gender = value;
  }

  public get gender(): string {
    return this._gender;
  }

  private _isDelete: number;

  public set isDelete(value: number) {
    this._isDelete = value;
  }

  public get isDelete(): number {
    return this._isDelete;
  }

  private _createdUser: string;

  public set createdUser(value: string) {
    this._createdUser = value;
  }

  public get createdUser(): string {
    return this._createdUser;
  }

  private _modifiedUser: string;

  public set modifiedUser(value: string) {
    this._modifiedUser = value;
  }

  public get modifiedUser(): string {
    return this._modifiedUser;
  }


  private _createdTime: Date;

  public set createdTime(value: Date) {
    this._createdTime = value;
  }

  public get createdTime(): Date {
    return this._createdTime;
  }

  private _modifiedTime: Date;

  public set modifiedTime(value: Date) {
    this._modifiedTime = value;
  }

  public get modifiedTime(): Date {
    return this._modifiedTime;
  }

  constructor(uid: number, username: string, password: string, salt: string, phone: string, email: string,
    avater: string, gender: string, isDelete: number, createdUser: string, modifiedUser: string,
    createdTime: Date, modifiedTime: Date) {
    this._uid = uid;
    this._username = username;
    this._password = password;
    this._salt = salt;
    this._phone = phone;
    this._email = email;
    this._avater = avater;
    this._gender = gender;
    this._isDelete = isDelete;
    this._createdUser = createdUser;
    this._modifiedUser = modifiedUser;
    this._createdTime = createdTime;
    this._modifiedTime = modifiedTime;
  }





}