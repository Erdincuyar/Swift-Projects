import SwiftUI
import AVKit
import AVFoundation

struct ContentView: View {
    @State private var showVideo = false
    @State private var showAlarm = false
    @State private var isFlashingBackground = false
    @State private var isTextVisible = true
    @State private var audioPlayer: AVAudioPlayer?

    // Video player 9. saniyeden başlasın
    let videoPlayer: AVPlayer = {
        let player = AVPlayer(url: Bundle.main.url(forResource: "iyiSaka", withExtension: "mp4")!)
        let time = CMTime(seconds: 9, preferredTimescale: 1)
        player.seek(to: time)
        return player
    }()

    init() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, options: [.mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Audio Session ayarlanamadı: \(error.localizedDescription)")
        }
    }

    var body: some View {
        ZStack {
            if showAlarm {
                Image("stolenImage")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .overlay(
                        Color(isFlashingBackground ? .red : .black)
                            .opacity(0.6)
                            .ignoresSafeArea()
                    )
                    .overlay(
                        Text("Çalıntı Şaka")
                            .font(.system(size: 50, weight: .black))
                            .foregroundColor(.white.opacity(isTextVisible ? 1 : 0))
                            .shadow(radius: 10)
                            .animation(Animation.linear(duration: 0.3).repeatForever(autoreverses: true), value: isTextVisible)
                    )
                    .onAppear {
                        startBackgroundFlashing()
                        startTextFlashing()
                        playAlarm()
                    }
                    .onTapGesture {
                        showAlarm = false
                        isFlashingBackground = false
                        isTextVisible = true
                        audioPlayer?.stop()
                    }
            } else {
                Color.white
                    .ignoresSafeArea()

                VStack(spacing: 60) {
                    Text("Meriz Şaka Değerlendirme")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.purple, Color.blue],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .shadow(color: .gray.opacity(0.6), radius: 4, x: 2, y: 2)

                    HStack(spacing: 60) {
                        Button(action: {
                            videoPlayer.seek(to: CMTime(seconds: 9, preferredTimescale: 1))
                            videoPlayer.play()
                            showVideo = true
                        }) {
                            Text("😂 İyi Şaka")
                                .foregroundColor(.white)
                                .frame(width: 100, height: 100)
                                .background(Color.green)
                                .clipShape(Circle())
                                .font(.headline)
                        }

                        Button(action: {
                            showAlarm = true
                        }) {
                            Text("🚨 Çalıntı Şaka")
                                .foregroundColor(.white)
                                .frame(width: 100, height: 100)
                                .background(Color.red)
                                .clipShape(Circle())
                                .font(.headline)
                        }
                    }
                }
            }

            if showVideo {
                ZStack(alignment: .topTrailing) {
                    VideoPlayer(player: videoPlayer)
                        .edgesIgnoringSafeArea(.all)

                    Button(action: {
                        showVideo = false
                        videoPlayer.pause()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.white)
                            .padding()
                    }
                }
            }
        }
    }

    func playAlarm() {
        if let path = Bundle.main.path(forResource: "alarm", ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()

                if let duration = audioPlayer?.duration {
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        withAnimation {
                            showAlarm = false
                            isFlashingBackground = false
                        }
                    }
                }
            } catch {
                print("Ses çalma hatası: \(error.localizedDescription)")
            }
        }
    }

    func startBackgroundFlashing() {
        isFlashingBackground = false
        Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { timer in
            withAnimation(.easeInOut(duration: 0.4)) {
                isFlashingBackground.toggle()
            }
            if !showAlarm {
                timer.invalidate()
                isFlashingBackground = false
            }
        }
    }

    func startTextFlashing() {
        isTextVisible = true
        Timer.scheduledTimer(withTimeInterval: 0.6, repeats: true) { timer in
            withAnimation(.linear(duration: 0.3)) {
                isTextVisible.toggle()
            }
            if !showAlarm {
                timer.invalidate()
                isTextVisible = true
            }
        }
    }
}
