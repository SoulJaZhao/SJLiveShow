// 引入express
var http = require("http");

var express = require("express");

// 创建web服务器
var server = http.Server(express);

// 引入socker
var socketIO = require("socket.io");

// 需要传入服务器，socket基于http
var socket = socketIO(server);

// 监听web服务器
server.listen(7349);

// 创建房间字典
var rooms = {};

//监听socket连接
socket.on('connection',function(clientSocket){
	console.log('建立连接');
	//监听创建房间
	clientSocket.on('createRoom',function(roomId,roomName){
		console.log('创建房间');
		//房间分组
		clientSocket.join(roomId);
		//创建房间
		rooms[roomId] = roomName;
		socket.to(roomId).emit('createRoomResult',roomId,roomName);
		clientSocket.roomId = roomId;
		var keys = Object.keys(rooms);
		console.log(keys);
		socket.sockets.emit('rooms',keys);
	});

	//监听删除房间
	clientSocket.on('deleteRoom',function(roomId){
		console.log('删除房间');
		delete rooms[roomId];
		clientSocket.leave(roomId);
		var keys = Object.keys(rooms);
		console.log(keys);
		socket.sockets.emit('rooms',keys);
	});

	//监听失去连接
	clientSocket.on('disconnect',function(){
		console.log('删除房间');
		delete rooms[clientSocket.roomId];
		clientSocket.leave(roomId);
		var keys = Object.keys(rooms);
		console.log(keys);
		socket.sockets.emit('rooms',keys);
	});

	//监听获取获取当前房间
	clientSocket.on('getRooms',function(){
		console.log('获取房间');
		var keys = Object.keys(rooms);
		console.log(keys);
		socket.sockets.emit('rooms',keys);
	});
});