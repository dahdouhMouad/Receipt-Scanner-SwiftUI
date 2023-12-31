//
//  HomeContentView.swift
//  Receipt ScannerSwiftUI
//
//  Created by Macbook Pro on 10/11/2023.
//

import SwiftUI

struct HomeContentView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        GeometryReader { gx in
            VStack {
                VStack {
                    Rectangle()
                        .ignoresSafeArea(.all)
                        .foregroundColor(.clear)
                        .frame(width:gx.size.width, height: 250)
                        .background(
                            LinearGradient(
                            stops: [
                                Gradient.Stop(color: CustomColor.myBlue, location: 0.00),
                                Gradient.Stop(color: CustomColor.myLighBlue, location: 1.00),
                            ],
                            startPoint: UnitPoint(x: 0.5, y: 0),
                            endPoint: UnitPoint(x: 0.5, y: 0.96)
                            )
                        )
                        .overlay {
                            VStack {
                                Text("Welcome back Mouad")
                                    .font(Font.custom("Colfax-Medium", size: 32))
                                    .kerning(0.64)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.leading)
                                
                                    ZStack {
                                        Rectangle()
                                                .foregroundColor(.clear)
                                                .frame(width: gx.size.width * 6/8, height: 142)
                                                .background(.green)
                                                .cornerRadius(6)
                                                .padding(.top,25)
                                        
                                        Rectangle()
                                            .foregroundColor(.clear)
                                            .frame(width: gx.size.width * 7/8, height: 142)
                                            .background(.white)
                                            .cornerRadius(6)
                                            .overlay {
                                                VStack(spacing: 8) {
                                                    Text("Today’s Expenditure")
                                                      .font(Font.custom("Colfax-Regular", size: 10))
                                                      .foregroundColor(CustomColor.myBlue)
                                                    
                                                    Text("220,252")
                                                      .font(
                                                        Font.custom("Colfax-Bold", size: 34)
                                                          .weight(.bold)
                                                      )
                                                      .foregroundColor(CustomColor.myBlue)
                                                }
                                            }
                                        }
                                }
                        }
                        
                    Spacer()
                        .frame(height: 18)
                    
                    HStack {
                        Text("Reminder")
                            .font(Font.custom("Colfax-Medium", size: 26))
                            .foregroundColor(CustomColor.myBlack)
                        Spacer()
                        Button {
                            
                        } label: {
                            AddAlertView(reminderList: $viewModel.reminderList)
                        }
                    }
                    .padding([.leading,.trailing], 30)
                    
                    List($viewModel.reminderList) { $reminder in
                        ReminderRow(reminder: $reminder)
                            .swipeActions {
                                Button {
                                    viewModel.removeReminder(reminder)
                                } label: {
                                    Text("Delete")
                                }
                            }
                    }
                    .listStyle(.plain)
                    
                }
                Spacer()
            }
        }
    }
}

struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentView()
    }
}

struct ReminderRow: View {
    @Binding var reminder: Reminder
    
    var body: some View {
        HStack {
            Button {
                reminder.isDone.toggle()
            } label: {
                Image(reminder.isDone == true ? "Check":"Unchecked")
            }
            .padding(.trailing)
            
            VStack {
                Text(reminder.title)
                    .font(Font.custom("Colfax-medium", size: 16))
                Text(reminder.dueDate.formatted())
                    .font(Font.custom("Colfax-medium", size: 10))
                    .foregroundColor(CustomColor.myBlack)
            }
        }
    }
}
