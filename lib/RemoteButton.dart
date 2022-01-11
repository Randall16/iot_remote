

enum RemoteButton {
  power,
  volumeUp,
  volumeDown,
  channelUp,
  channelDown,
  mute,
  input,
  select,
  up,
  down,
  left,
  right,
  zero,
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine
}

String convertRemoteButtonToApiString(RemoteButton remoteButton) {
  switch (remoteButton) {
    case RemoteButton.power:
      return 'POWER';
    case RemoteButton.volumeUp:
      return 'VOLUME_UP';
    case RemoteButton.volumeDown:
      return 'VOLUME_DOWN';
    case RemoteButton.channelUp:
      return 'CHANNEL_UP';
    case RemoteButton.channelDown:
      return 'CHANNEL_DOWN';
    case RemoteButton.mute:
      return 'MUTE';
    case RemoteButton.input:
      return 'INPUT';
    case RemoteButton.select:
      return 'SELECT';
    case RemoteButton.up:
      return 'UP';
    case RemoteButton.down:
      return 'DOWN';
    case RemoteButton.left:
      return 'LEFT';
    case RemoteButton.right:
      return 'RIGHT';
    case RemoteButton.zero:
      return 'ZERO';
    case RemoteButton.one:
      return 'ONE';
    case RemoteButton.two:
      return 'TWO';
    case RemoteButton.three:
      return 'THREE';
    case RemoteButton.four:
      return 'FOUR';
    case RemoteButton.five:
      return 'FIVE';
    case RemoteButton.six:
      return 'SIX';
    case RemoteButton.seven:
      return 'SEVEN';
    case RemoteButton.eight:
      return 'EIGHT';
    case RemoteButton.nine:
      return 'NINE';
  }
}