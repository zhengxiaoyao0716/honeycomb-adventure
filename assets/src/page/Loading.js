import React from 'react';
const styles = {
    index: require('./index.css'),
    Clock: require('./Clock.css'),
};

const Loading = () => (<div className={styles.index.Modal}>
    <div className={styles.Clock.Clock} style={{ width: 64, height: 64, top: '50%', marginTop: -32, boxShadow: '0 0 3px 0 #fff' }}>
        <span className={styles.Clock.Milli}></span>
        <span className={styles.Clock.Second}></span>
        <span className={styles.Clock.Minute}></span>
    </div>
</div>);
export default Loading;
